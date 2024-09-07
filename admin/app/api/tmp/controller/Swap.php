<?php
namespace app\api\controller;

use app\api\controller\BaseController;
use app\model\CoinDefineModel;
use app\model\UsersModel;

/**
 * Class Swap
 *
 * @package app\api\controller
 * @middleware app\api\middleware\CheckToken
 *
 * @description 处理用户转换coin
 */
class Swap extends BaseController
{
    protected $middleware = ['app\api\middleware\CheckToken::class'];

    /**
     * 获取用户所有coin钱包余额.
     * @model
     * @description  首先获取平台所有coin。然后获取用户相应虚拟币的金额
     *
     */
    public function getCoinInfo()
    {
        $uid = request()->payload['id'];
        $data = CoinDefineModel::mk()->alias('cd')->leftJoin('users_secondary_wallet u', 'u.coin_id = cd.id AND u.uid =' . $uid)
            ->where('cd.status', 1)
            ->field('cd.id,cd.code,CONCAT("/storage/coin/",cd.image) as image,IFNULL(u.balance, 0) as balance')->select()->toArray();
        $usdt = [
            'id' => 0,
            "code" => "USDT",
            "image" => "",
            "balance" => UsersModel::mk()->where('id', $uid)->value('usdt'),

        ];
        array_unshift($data, $usdt);
        return $this->success('操作成功', $data);

    }

    public function getCoinPairPrice()
    {
        $coinList = CoinDefineModel::mk()->where('status', 1)->column('code', 'id');
        $coinFromSymbol = input('from');
        $coinToSymbol = input('to');
        $symbols = [];
        if (!in_array($coinFromSymbol, $coinList) && $coinFromSymbol !== 'USDT') {
            return $this->error('参数错误或缺少参数');
        }
        if (!in_array($coinToSymbol, $coinList) && $coinToSymbol !== 'USDT') {
            return $this->error('参数错误或缺少参数');
        }

        if($coinFromSymbol !=='USDT'){
          $symbols[] = $coinFromSymbol.'USDT';
        }
        if($coinToSymbol !=='USDT'){
          $symbols[] = $coinToSymbol.'USDT';
        }
       
    }
}
