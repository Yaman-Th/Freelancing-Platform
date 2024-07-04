<?php

use Illuminate\Support\Facades\Route;
use App\Mail\myEmail;

Route::get('/', function () {
    return view('welcome');
});
