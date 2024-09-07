<?php
namespace app\api\controller;

use app\api\controller\BaseController;
use app\model\CoinDefineModel;
use app\model\UsersModel;
use app\Service\BinanceService;

/**
 * Class Assets
 *
 * @package app\api\controller
 * @middleware app\api\middleware\CheckToken
 *
 * @description 处理前段 assets 页面
 */
class Assets extends BaseController
{
    protected $middleware = ['app\api\middleware\CheckToken::class'];

    /**
     * 获取用户钱包余额.
     * @model users
     * @description  获取用户所有钱包余额，
     * @return \think\response\Json 返回用户所有钱包余额
     */
    public function getPlatformAssetMasterAccount()
    {
        $uid = request()->payload['id'];
        $data = [];
        $name = input('name', 0);

        if (!in_array($name, [0, 1, 2])) {
            return $this->error('缺少参数或参数错误');
        }
        if ($name == 0) {
            $usdt = UsersModel::mk()->where('id', $uid)->field('usdt,usdt_occupancy')->find();
            $data['balance'] = $usdt['usdt'];
            $data['occupancy'] = $usdt['usdt_occupancy'];
            $data['disassembly'] = $usdt['usdt'];

        } elseif ($name == 1) {
            $usdt = UsersModel::mk()->where('id', $uid)->field('financial_usdt')->find();
            $data['balance'] = $usdt['financial_usdt'];
            $data['occupancy'] = '0.0000';
            $data['disassembly'] = $usdt['financial_usdt'];
        } else {
            $usdt = UsersModel::mk()->where('id', $uid)->field('contract_usdt')->find();
            $data['balance'] = $usdt['contract_usdt'];
            $data['occupancy'] = '0.0000';
            $data['disassembly'] = $usdt['contract_usdt'];
        }

        return $this->success('操作成功', $data);

    }

    /**
     * 获取用户钱包余额.
     * @model CoinDefineModel
     * @description  获取用户所有钱包余额，
     * @return \think\response\Json 返回用户所有钱包余额
     */
    public function getOtherWallet()
    {
        $uid = request()->payload['id'];
        $coinList = CoinDefineModel::mk()->where('status', 1)->column('id', 'CONCAT(code,"USDT")');

        $symbols = array_keys($coinList);
        $prices = BinanceService::instance()->getBinanceData($symbols);

        $dataPrice = [];
        foreach ($prices as $key => $coin) {
            $dataPrice[$coin['symbol']] = $coin['prevClosePrice'];
        }

        $data = CoinDefineModel::mk()->alias('w')->leftJoin('users_secondary_wallet s', 's.coin_id = w.id')
            ->where(['s.uid' => $uid])->field('w.code,CONCAT("/storage/coin/",w.image) as image,s.balance,s.occupancy')->select();
        if (!$data) {
            $data = $data->toArray();
        }

        foreach ($data as &$price) {
            $price['disassembly'] = $price['balance'] * $dataPrice[$price['code'] . 'USDT'];
        }

        return $this->success('操作成功', $data);

    }
}
