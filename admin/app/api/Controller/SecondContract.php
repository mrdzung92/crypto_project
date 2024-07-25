<?php
namespace app\api\controller;

use app\api\controller\BaseController;
use app\api\Validate\TradeSecondValidate;
use app\model\CoinDefineModel;
use app\model\SecondContractModel;
use app\Queue\CheckBetResult;
use app\Service\BinanceService;
use think\facade\Db;
use think\facade\Queue;

/**
 * Class SecondContract
 *
 * @package app\api\controller
 * @middleware app\api\middleware\CheckToken
 *
 * @description 处理投注秒合约 包括投注，相关配置，进行投注事务
 */
class SecondContract extends BaseController
{
    protected $queueName = 'checkBetResult';
    protected $middleware = ['app\api\middleware\CheckToken::class'];
    /**
     * 获取投注配置.
     * @model
     * @description  首先从 coin_define 数据库获取 rate_setting 字段 如果是NUll 再进入second_contract_rate_default数据库 获取默认配置
     * @return \think\response\Json 返回数据 是配置 id(数据) time(投注时间),rate(盈利百分比)
     */
    public function getSecondContractDetails()
    {
        $code = input('code', '');
        if ($code == '') {
            return $this->error('缺少参数');
        }

        $coinDefineRate = CoinDefineModel::mk()->where('code', $code)->field('id,code,rate_setting')->findOrEmpty();
        if ($coinDefineRate->isEmpty()) {
            return $this->error('虚拟币代码不存在');
        }

        if ($coinDefineRate->rate_setting !== null) {
            return $this->success('操作成功', $coinDefineRate);
        }

        $coinDefineRate = $coinDefineRate->toArray();
        $coinDefineRate['rate_setting'] = $this->getDefaultRate();
        return $this->success('操作成功', $coinDefineRate);

    }

    /**
     * 获取默认配置投注.
     * @sql_table second_contract_rate_default
     * @description  在 second_contract_rate_default 数据库获取   id(数据) time(投注时间),rate(盈利百分比)
     * @return \think\response\Json 返回数据 是配置 id(数据) time(投注时间),rate(盈利百分比)
     */
    private function getDefaultRate()
    {
        $coinRate = Db::table('second_contract_rate_default')->field('id,time,rate')->select()->toArray();
        return $coinRate;
    }
    /**
     * 创建投注订单
     * @validate  app\api\Validate\TradeSecondValidate
     * @sql_table second_contract_order
     * @service app\api\Service\BinanceService
     * @model app\model\SecondContractModel
     * @description 创建投注订单，
     * @return \think\response\Json 成功返回订单详情 ， 用户剩下余额
     */
    public function makeOrder()
    {
        $input = input();
        $rate_setting = $this->getDefaultRate();
        //证实数据
        try {
            validate(TradeSecondValidate::class)->check($input);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }
        $coinDefineRate = CoinDefineModel::mk()->where('id', $input['coinId'])->where('status', 1)->field('id,code,rate_setting')->findOrEmpty();
        if ($coinDefineRate->isEmpty()) {
            return $this->error('虚拟币代码不存在');
        }
        if ($coinDefineRate->rate_setting !== null) {
            $rate_setting = $coinDefineRate->rate_setting;
        }
        $rate = [];
        foreach ($rate_setting as $value) {
            if ($value['id'] === $input['rateId']) {
                $rate = $value;
                break;
            }
        }
        if (empty($rate)) {
            return $this->error('虚拟币配置不存在');
        }
        $priceInfo = BinanceService::instance()->getBinanceDataBySymbol($coinDefineRate->code . 'USDT');

        Db::startTrans();
        try {
            $uid = request()->payload['id'];
            $username = request()->payload['username'];
            $data = [
                'username' => $username,
                'uid' => $uid,
                'time' => $rate['time'],
                'rate' => $rate['rate'],
                'code' => CoinDefineModel::mk()->where('id', $input['coinId'])->value('code'),
                'direction' => $input['direction'],
                'start_price' => $priceInfo['askPrice'],
                'add_time' => time(),
                'bet_amount' => $input['quantity'],
            ];
            //保存数据库
            $betId = SecondContractModel::mk()->insertGetId($data);
            //创建订单号更新到数据库
            $order = 'T' . date('Ymd') . str_repeat("0", 12 - strlen($betId)) . $betId;
            $result = SecondContractModel::mk()->where('id', $betId)->update(['order_num' => $order]);

            // 提交事务
            Db::commit();
            //返回前段数据
            $returnData = [
                'bet_id' => $betId,
                'curr_price' => $data['start_price'],
                'time' => $data['time'],
                'direction' => $data['direction'],
                'bet_amount' => $data['bet_amount'],
                'expected_profit' => $data['bet_amount'] * $data['rate'] / 100,
                'start_price' => $data['start_price'],
                'add_time' => date('Y/m/d H:i:s', $data['add_time']),
                'code' => $data['code'],
            ];

        } catch (\Exception $e) {
            // 回滚事务
            return $this->error($e->getMessage());
            Db::rollback();
        }
        //加入队列处理
        Queue::later($rate['time'] - 1, CheckBetResult::class, ['betId' => $betId, 'symbol' => $returnData['code'] . 'USDT'], $this->queueName);
        return $this->success('操作成功', $returnData);
    }

    /**
     * 获取投注列表
     * @sql_table second_contract_order
     * @model app\model\SecondContractModel
     * @description 处理用户获取投注订单列表，
     * @return \think\response\Json 成功返回订单列表，未结算订单总数， 已结算订单总数
     */
    public function orderList()
    {
        $data = [
            'countSettled' => 0,
            'countUnsettlement' => 0,
            'list' => [],
        ];
        $query = '';
        $type = input('type', 1);
        if (!in_array($type, [1, 2])) { //$type 1 未结算， 2 已结算
            $type = 1;
        }

        if ($type == 1) {
            $query = SecondContractModel::mk()
                ->where('status', 1)->where('uid', request()->payload['id'])
                ->field('id as bet_id,start_price as curr_price,start_price,time,direction,0 as expected_profit,bet_amount,FROM_UNIXTIME(add_time,"%Y/%m/%d %H:%i:%s") as add_time,code')->order('id', 'desc')->select();
        } else {
            $query = SecondContractModel::mk()
                ->whereIn('status', '2,3,4')->where('uid', request()->payload['id'])
                ->field('id as bet_id,end_price,start_price,time,direction,0 as expected_profit,bet_amount,FROM_UNIXTIME(add_time,"%Y/%m/%d %H:%i:%s") as add_time,FROM_UNIXTIME(settlement_time,"%Y/%m/%d %H:%i:%s") as settlement_time,code,bet_result')->order('id', 'desc')->select();
        }

        if ($query) {
            $query = $query->toArray();
            $data['list'] = $query;
        }
        $data['countUnsettlement'] = SecondContractModel::mk()->where('status', 1)->where('uid', request()->payload['id'])->count('id');
        $data['countSettled'] = SecondContractModel::mk()->whereIn('status', '2,3,4')->where('uid', request()->payload['id'])->count('id');
        return $this->success('操作成功', $data);

    }

    /**
     * 处理最后投注订单弹窗信息
     * @sql_table second_contract_order
     * @model app\model\SecondContractModel
     * @return \think\response\Json 返回用户投注订单详情
     */
    public function checkBetResult()
    {

        $betId = input('betId');
        if ($betId == '') {
            return $this->error('缺少参数');
        }

        $uid = request()->payload['id'];
        $betData = SecondContractModel::mk()->where('uid', $uid)
            ->where('id', $betId)
            ->field('id as bet_id,end_price,start_price,time,direction,0 as expected_profit,bet_amount,FROM_UNIXTIME(add_time,"%Y/%m/%d %H:%i:%s") as add_time,FROM_UNIXTIME(settlement_time,"%Y/%m/%d %H:%i:%s") as settlement_time,code,bet_result')
            ->findOrEmpty();
        if ($betData->isEmpty()) {
            return $this->error('订单不存在');
        }
        return $this->success('操作成功', $betData);
    }

}
