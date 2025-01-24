<?php
/**
 * 玩家管理
 * @class Slider
 * @package app\setting\controller
 */

namespace app\setting\controller;

use app\model\SliderModel;
use think\admin\Controller;
use think\admin\helper\QueryHelper;

class Slider extends Controller
{
    /**
     * 玩家用户
     * @auth true
     * @menu true
     */
    public function index()
    {
        SliderModel::mQuery()
            ->layTable(function () {
                $this->title = '玩家用户';
            }, static function (QueryHelper $query) {

            });
    }

    /**
     * 添加数据字典
     * @auth true
     */
    public function add()
    {
        SystemBase::mForm('form');
    }
    
    /**
     * 编辑数据字典
     * @auth true
     */
    public function edit()
    {
        SystemBase::mForm('form');
    }

}
