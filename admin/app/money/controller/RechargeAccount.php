<?php
/**
 * 玩家管理
 * @class Users
 * @package app\users\controller
 */
namespace app\money\controller;
use think\admin\helper\QueryHelper;
use think\admin\Controller;
use app\model\UsersModel;
class RechargeAccount extends Controller
{
    /**
     * 玩家用户
     * @auth true
     * @menu true
     */
    public function index()
    {
        UsersModel::mQuery()->layTable(function () {
            $this->title = '玩家用户';
        }, static function (QueryHelper $query) {
            $query->like('username,nickname')->equal('status')->dateBetween('create_at');
        });
    }


}