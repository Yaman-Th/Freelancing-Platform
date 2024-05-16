<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Models\User;
use App\Models\EmailVerfcation;




Route::post('/users/register',[AuthController::class,'Register']);

Route::post('/users/login',[AuthController::class,'login']);


Route::post('/users/resetPasswordEmail',[AuthController::class,'changePassword']);




Route::group((['middleware' => ['auth:sanctum']]), function () {



   

    Route::post('/users/logout',[AuthController::class,'logout']);
    
    Route::post('password/change', [AuthController::class,'changePassword']);
});



Route::get('/user', function (Request $request) {
})->middleware('auth:sanctum');




Route::post('/verify-email', function (Request $request) {
    $request->validate([
        'email' => 'required|email',
        'token' => 'required|string',
    ]);

    $verification = EmailVerfcation::where('email', $request->email)
                                      ->where('token', $request->token)
                                      ->first();

    if ($verification) {
        $user = User::where('email', $request->email)->first();
        $user->email_verified_at = now();
        $user->save();

        // حذف سجل التحقق بعد التحقق الناجح
        $verification->delete();

        return response()->json(['message' => 'Email verified successfully.']);
    }

    return response()->json(['message' => 'Invalid verification code.'], 400);
});