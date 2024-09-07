<?php
namespace app\api\Validate;

use think\Validate;

class TradeSecondValidate extends Validate
{
    protected $rule = [
        'coinId' => 'require|integer',
        'rateId' => 'require|integer',
        'direction' => 'require|in:up,down',
        'quantity' => 'require|float|gt:0',
    ];

    protected $message = [
        // 'coinId.require' => '',
        // 'rateId.require' => '',
        // 'quantity.require' => '',
        // 'direction.require' => '',
        // 'direction.in' => '',
    ];

}
