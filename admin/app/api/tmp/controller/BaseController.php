<?php
namespace app\api\controller;

use think\admin\Controller;
use think\App;
class BaseController extends Controller
{

    // public function __construct(App $app)
    // {
    //     parent::__construct($app);
      
      
    // }
    protected function _success($msg = '', $data = [])
    {
        return json(['success' => true, 'msg' => $msg, 'data' => $data]);
    }

    protected function _error($msg = '', $data = [])
    {
        return json(['success' => false, 'msg' => $msg, 'data' => $data]);
    }

}
