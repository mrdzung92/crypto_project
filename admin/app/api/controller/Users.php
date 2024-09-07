<?php
namespace app\api\controller;

use app\api\controller\BaseController;
use app\model\UsersModel;
/**
 * Class Users
 *
 * @package app\api\controller
 * @middleware app\api\middleware\CheckToken
 *
 * @description 处理与用户相关事项
 */
class Users extends BaseController
{
    protected $middleware =  ['app\api\middleware\CheckToken::class'];

    /**
     * 获取用户钱包余额.
     * @model users
     * @description  获取用户主钱包余额，
     * @return \think\response\Json 返回数据 用户余额
     */
    public function getUsersCoin(){
        $uid = request()->payload['id'];
        $coin = UsersModel::mk()->where('id',$uid)->value('usdt');
        return $this->success('操作成功', $coin);

    }
}