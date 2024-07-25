<?php

namespace app\Service;

use think\admin\service\AdminService;

/**
 * 插件服务注册
 * @class BinanceService
 * @package app\api\Service
 */
class BinanceService extends AdminService
{
    /**
     * @param array $symbols coinList
     * @return array
     */
    public function getBinanceData($symbols)
    {
        $url = 'https://api.binance.com/api/v3/ticker/24hr';
        $query = http_build_query(['symbols' => json_encode($symbols)]);
        $data = json_decode($this->curlGet($url . '?' . $query), true);
        return $data;
    }

    public function curlGet($url)
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        $output = curl_exec($ch);
        curl_close($ch);
        return $output;
    }

    public function getBinanceDataBySymbol($symbol)
    {
        $url = 'https://api.binance.com/api/v3/ticker/24hr?symbol=' . $symbol;
        $data = $this->curlGet($url);
        return json_decode($data, true);
    }

}
