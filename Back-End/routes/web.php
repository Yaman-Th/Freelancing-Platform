<?php

use Illuminate\Support\Facades\Route;
use App\Mail\myEmail;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/testroute', function () {
    // $content = "1098";
    // Mail::to('tahhan152@gmail.com')->send(new myEmail($token));
});
