<?php
namespace app\Queue;

use app\Service\BinanceService;
use app\model\SecondContractModel;
use think\queue\Job;

class CheckBetResult
{
    public function fire(Job $job, $data)
    {

        // 将超时设置为 5 秒
        pcntl_signal(SIGALRM, function () use ($job) {
            echo "Timeout: Job took too long to complete.";
            $job->delete();
            exit();
        });
        pcntl_alarm(5); // 设置5秒超时
        try {
            echo 'Starting job for: ' . json_encode($data) . '\n';
            $betId = $data['betId'];
            $symbol = $data['symbol'];
            $betInfo = SecondContractModel::mk()->where('id', $betId)->field('rate,time,direction,start_price,add_time,bet_amount,status')->find();
            $now = time();
            if ($betInfo['status'] !== 1 || $betInfo['add_time'] - $now >= 30) {
                echo 'Skipping job for bet ID ' . $betId . ' because status is not 1 \n';
                $job->delete();
                return;
            }
            $result = $betInfo['bet_amount'] *  $betInfo['rate']/100;
            $priceInfo = BinanceService::instance()->getBinanceDataBySymbol($symbol);

            $updateBetData = [
                'end_price' => $priceInfo['askPrice'],
                'status' => 2,
                'settlement_time' => $betInfo['add_time'] + $betInfo['time'],
            ];
            if ($betInfo['direction'] === 'up') {
                if ($priceInfo['askPrice'] > $betInfo['start_price']) {
                    $updateBetData['bet_result'] = $result;
                } elseif ($priceInfo['askPrice'] < $betInfo['start_price']) {
                    $updateBetData['bet_result'] = '-' . $result;
                } else {
                    $updateBetData['bet_result'] = 0;
                }
            } else {
                if ($priceInfo['askPrice'] < $betInfo['start_price']) {
                    $updateBetData['bet_result'] = $result;
                } elseif ($priceInfo['askPrice'] > $betInfo['start_price']) {
                    $updateBetData['bet_result'] = '-' . $result;
                } else {
                    $updateBetData['bet_result'] = 0;
                }
            }
            
            SecondContractModel::mk()->where('id', $betId)->update($updateBetData);
            $job->delete();
        } finally {
            pcntl_alarm(0);
        }
    }

    
}
