<?php

use Carbon\Carbon;
use App\Models\Order;

Validator::extend('current_password', function($attribute, $value, $parameters) {
    return Hash::check($value, Auth::user()->password);
}, '密码错误');

Validator::extend('phone', function($attribute, $value, $parameters) {
    return preg_match('/^((13[0-9])|(15[^4,\\D])|(18[0,2,5-9]))\\d{8}$/', $value);
}, '手机号格式不正确');

Validator::extend('idcard', function($attribute, $value, $parameters) {
    return preg_match('/^\d{17}[x|\d]$/', $value);
}, '身份证号格式不正确');

Validator::extend('live_half_month_and_not_conflict', function($attribute, $value, $parameters, $validator) {
    $check_in_at = Carbon::parse($validator->getData()['check_in_at']);
    $check_out_at = Carbon::parse($value);

    // check time scope
    if ($check_in_at->diffInDays($check_out_at) > 15) {
        return false;
    }

    // not conflict
    $no = $validator->getData()['no'];
    $currOrders = Order::where('room_no', $no)
        ->where('check_out_at', '>=' ,Carbon::today())
        ->select('check_in_at', 'check_out_at')
        ->get();

    $conflict = count($currOrders) != 0;

    foreach ($currOrders as $order) {
        if ($check_in_at > $order->check_out_at || $check_out_at < $order->check_in_at) {
            $conflict = false;
        } else {
            $conflict = true;
            break;
        }
    }

    return ! $conflict;
}, '最多只能预定半个月，或者时间冲突，请查看右边当前预定时间');
