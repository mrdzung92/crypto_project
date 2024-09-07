<?php
/**
 * 玩家管理
 * @class Users
 * @package app\users\controller
 */
namespace app\users\controller;

use app\model\UsersModel;
use Ip2Region;
use think\admin\Controller;
use think\admin\helper\QueryHelper;

class Users extends Controller
{
    /**
     * 玩家用户
     * @auth true
     * @menu true
     */
    public function index()
    {
        UsersModel::mQuery()->alias('u1')->leftJoin('users u2', 'u1.parent_id = u2.id')
            ->field('u1.username,u1.parent_id,u1.usdt,u1.online_status,
        u1.status,u1.user_type,u2.username as parent_account,
        u1.login_ip,FROM_UNIXTIME(u1.login_time) as login_time,FROM_UNIXTIME(u1.register_time) as register_time,u1.register_ip')
            ->layTable(function () {
                $this->title = '玩家用户';
            }, static function (QueryHelper $query) {
                $query->like('username,nickname')->equal('status')->dateBetween('create_at');
            });
    }
    /**
     * 二次处理数据
     * @param array $data
     */
    protected function _page_filter(&$data)
    {
        $region = new Ip2Region();
        foreach ($data as &$vo) {
            $vo['login_ip'] = long2ip($vo['login_ip']);
            $vo['register_ip'] = long2ip($vo['register_ip']);
           
            $vo['login_isp'] = $region->simple($vo['login_ip']);
            $vo['register_isp'] = $region->simple($vo['register_ip']);

        }
    }

}
