<?php
namespace app\api\controller;

use app\api\controller\BaseController;
use app\model\UsersModel as MainModel;

/**
 * Class Users
 *
 * @package app\api\controller
 * @middleware app\api\middleware\CheckToken
 *
 * @description 处理代理相关问题
 */
class Agent extends BaseController
{
    protected $middleware = ['app\api\middleware\CheckToken::class'];
    protected $model;
    public function __construct()
    {
        // parent::__construct();

        $this->model = new MainModel();
    }
     /**
     * 获取投注配置.
     * @model
     * @description  获取用户一条代理线下会员， 从 第一级到第三极 人数
     * @return \think\response\Json 返回数据 返回数据 sumCount 会员总数，oneCount 一级用户，twoCount 二级用户，threeCount 三级用户，sumAmount 总佣金
     */
    public function getAgentDetail()
    {
        $uid = request()->payload['id'];
        $data = [
            'sumCount' => 0,
            'oneCount' => 0,
            'twoCount' => 0,
            'threeCount' => 0,
            'sumAmount' => 0,
        ];
        $agentLevel = $this->model->getAgentLevel($uid, 3);
        if (!empty($agentLevel)) {
            foreach ($agentLevel as $user) {
                if ($user['level'] == 1) {
                    $data['oneCount'] += 1;
                } elseif ($user['level'] == 2) {
                    $data['twoCount'] += 1;
                } else {
                    $data['threeCount'] += 1;
                }
            }
            $data['sumCount'] = array_sum($data);
            $data['invite_code'] = MainModel::where('id', $uid)->value('invite_code');
        }

        return $this->success('操作成功', $data);

    }
    public function getAgentMemberList()
    {
        $level = input('level', 1);
        $uid = request()->payload['id'];
        $data = $this->model->getAgentMemberDetail($uid, $level);
        return $this->success('操作成功', $data);
    }
}
