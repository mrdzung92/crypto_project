<?php
namespace app\api\controller;

use app\api\controller\BaseController;
use app\model\UsersModel;

/**
 * Class Transfer
 *
 * @package app\api\controller
 * @middleware app\api\middleware\CheckToken
 *
 * @description 理财账户， 平台usdt账户， 合约账户 额度转换
 */
class Transfer extends BaseController
{
    protected $middleware = ['app\api\middleware\CheckToken::class'];

    /**
     * 获取理财账户， 平台usdt账户， 合约账户余额.
     * @model
     */
    public function getBalance()
    {
        $uid = request()->payload['id'];
        $data = UsersModel::mk()->where('id', $uid)->field('usdt as value1,contract_usdt as value2,financial_usdt as value3')->find();

        return $this->success('操作成功', $data);

    }

    public function startTransfer()
    {
        //  1主账号余额usdt， 2合约账号 ， 3理财账号

        $from = input('from');
        $to = input('to');
        $transfer = input('transfer');

        if (!in_array($from, [1, 2, 3])) {
            return $this->error('参数不正确');
        }
        if (!in_array($to, [1, 2, 3])) {
            return $this->error('参数不正确');
        }
        if ($to === $from) {
            return $this->error('发送帐户必须与目标帐户不同');
        }
        if ($transfer <= 1) {
            return $this->error('转换金额不能为空或者小于1');
        }
        $uid = request()->payload['id'];
        $balance = UsersModel::mk()->where('id', $uid)->field('usdt as v1,contract_usdt as v2,financial_usdt as v3')->find();
        if ($transfer > $balance['v' . $from]) {
            return $this->error('转换金额大于账号余额');
        }
        // 定义
        $definition = [
            'v1' => 'usdt',
            'v2' => 'contract_usdt',
            'v3' => 'financial_usdt',
        ];
        UsersModel::mk()->where('id', $uid)->update([
            $definition['v'.$from] =>  $balance['v' . $from] - $transfer,
            $definition['v'.$to] =>  $balance['v' . $to] + $transfer,
        ]);

        $this->success('操作成功');

    }
}
