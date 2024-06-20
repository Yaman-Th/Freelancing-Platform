<?php

use App\Models\Auth\User;
use App\Models\Auth\client;
use Illuminate\Http\Request;
use App\Models\Auth\Freelancer;
use App\Models\Auth\EmailVerfcation;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\FreelancerController;




Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);


// Routes for freelancer actions
Route::middleware('auth:sanctum')->group(function () {
    // user api 
        Route::post('/logout', [AuthController::class, 'logout']);
        Route::post('/change-password', [AuthController::class, 'changePassword']);
    // freelancer api 
        Route::post('/freelancer/profile/{id}', [FreelancerController::class, 'profile']);
        Route::post('/freelancer/upgrade', [FreelancerController::class, 'upgrade']);
        Route::post('/freelancer/update', [FreelancerController::class, 'update']);
        Route::post('/freelancer/addservice', [FreelancerController::class, 'addService']);
    // client api 
    Route::post('/client/upgrade', [FreelancerController::class, 'upgrade']);
    Route::post('/client/update', [FreelancerController::class, 'update']);

    
    
    //Route services
    // Route::post('/freelancer/services', [ServiceController::class, 'addService']);
    // Route::put('/freelancer/services/{service}', [ServiceController::class, 'updateService']);
    // Route::delete('/freelancer/services/{service}', [ServiceController::class, 'deleteService']);
    // Route::get('/freelancer/services', [ServiceController::class, 'listServices']); // List all services by the freelancer
    // Route::get('/freelancer/orders', [FreelancerController::class, 'listOrders']); // List all orders received
    //Route::post('/freelancer/orders/{order}/accept', [FreelancerController::class, 'acceptOrder']); // Accept an order
    //Route::post('/freelancer/orders/{order}/reject', [FreelancerController::class, 'rejectOrder']); // Reject an order

});

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