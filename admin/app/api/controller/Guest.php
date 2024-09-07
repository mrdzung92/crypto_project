<?php
namespace app\api\controller;

use app\api\controller\BaseController;
use app\Service\BinanceService;
use app\Service\UsersService;
use app\api\validate\AuthValidate;
use app\model\CoinDefineModel;
use app\model\UsersModel;
use think\captcha\facade\Captcha;
use think\exception\Exception;
use think\facade\Db;

class Guest extends BaseController
{
    public function getConfig()
    {
        $config['default_coin'] = 'BTCUSDT';
        $defaultCoin = CoinDefineModel::where('status', 1)->field('code')->find();
        if ($defaultCoin) {
            $config['default_coin'] = $defaultCoin->code.'USDT';
        }

        return $this->success('操作成功', $config);
    }

    public function getVerifyCode()
    {
        $uniqid = uniqid(mt_rand(100000, 999999));
        return json(['success' => true, 'msg' => 'success', 'data' => ['uniqid' => $uniqid, 'captcha_src' => captcha_src() . '?uniqid=' . $uniqid]]);
    }

    public function auth()
    {
        $data = input();
        $dataReturn = [];
        $scene = (isset($data['login_type']) && $data['login_type'] == true) ? 'login' : 'register';

        if (!isset($data['verify_code']) || !Captcha::check($data['verify_code'], $data['uniqid']) || empty($data['verify_code']) || empty($data['uniqid'])) {
            return $this->error('验证码错误');
        }

        try {
            validate(AuthValidate::class)->scene($scene)->check($data);
        } catch (\think\exception\ValidateException $e) {
            return $this->error($e->getError());
        }

        if ($scene == 'login') {
            $userInfo = UsersModel::where('username', $data['username'])->findOrEmpty();
            if ($userInfo->isEmpty() || !password_verify($data['password'], $userInfo->password)) {
                return $this->error('用户名或密码错误');
            }

            $userData = [
                'login_time' => time(),
                'login_ip' => ip2long(request()->ip()),
            ];
            $dataReturn = [
                'id' => $userInfo->id,
                'username' => $userInfo->username,
            ];

            UsersModel::where('id', $userInfo->id)->update($userData);
        } else {
            //注册时间
            $invite_code = input('invite_code');
            $parent_id = 0;
            if ($invite_code !== '') {
                $parent_id = UsersModel::where('invite_code', $invite_code)->value('id');
            }

            Db::startTrans();
            try {

                $userData = [
                    'username' => $data['username'],
                    'password' => password_hash($data['password'], PASSWORD_BCRYPT),
                    'invite_code' => UsersService::instance()->genergorInviteCode(),
                    'register_ip' => ip2long(request()->ip()),
                    'register_time' => time(),
                    'login_ip' => ip2long(request()->ip()),
                    'parent_id' => $parent_id,
                    'login_time' => time(),
                ];
                $newUser = UsersModel::create($userData);
                // 提交事务
                Db::commit();
                $dataReturn = [
                    'id' => $newUser->id,
                    'username' => $newUser->username,
                ];
            } catch (Exception $e) {
                // 回滚事务
                Db::rollback();
                return $this->error('注册失败');

            }

        }
        $dataReturn['token'] = UsersService::instance()->createJwt($dataReturn);
        UsersService::instance()->saveRedis($dataReturn);
        return $this->success('登录成功', $dataReturn);

    }
    public function coinList()
    {
        $coinList = CoinDefineModel::mk()->where('status', 1)->column('CONCAT("/storage/coin/",image) as icon', 'CONCAT(code,"USDT")');
        $symbols = array_keys($coinList);
        $data = BinanceService::instance()->getBinanceData($symbols);
        foreach ($data as $key => $value) {
            $data[$key]['icon'] = $coinList[$value['symbol']]['icon'];
        }
        return $this->success('success', $data);
    }

    public function HomeTopCoin()
    {
        $coinList = CoinDefineModel::mk()->where('status', 1)->where('home_top', 1)->column('CONCAT("/storage/coin/",image) as icon', 'CONCAT(code,"USDT")');
        $symbols = array_keys($coinList);
        $data = BinanceService::instance()->getBinanceData($symbols);
        return $this->success('success', $data);
    }
    public function getCoinPriceBySymbol()
    {
        $symbol = input('symbol');
        $symbols = CoinDefineModel::mk()->where('status', 1)->column('code');
        if (!in_array(str_replace('USDT', '', $symbol), $symbols)) {
            $symbol = $symbols[0] . 'USDT';
        }
        $data = BinanceService::instance()->getBinanceDataBySymbol($symbol);
        return $this->success('操作成功', $data);

    }
}
