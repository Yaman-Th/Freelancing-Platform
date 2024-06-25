<?php

use App\Models\Auth\User;
use App\Models\Auth\client;
use Illuminate\Http\Request;
use App\Models\Auth\Freelancer;
use App\Models\Auth\EmailVerfcation;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ClientController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\ServiceController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\FreelancerController;

// Public Routes
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);


// Routes for freelancer actions
Route::middleware('auth:sanctum')->group(function () {
    // user api 
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::post('/change-password', [AuthController::class, 'changePassword']);
    Route::post('/verify-email', function (Request $request) {
        $request->validate([
            'email' => 'required|email',
            'token' => 'required|string',
        ]);
        // freelancer api 
        Route::post('/freelancer/profile/{id}', [FreelancerController::class, 'profile']);
        Route::post('/freelancer/upgrade', [FreelancerController::class, 'upgrade']);
        Route::post('/freelancer/update', [FreelancerController::class, 'update']);
        Route::post('/freelancer/addservice', [FreelancerController::class, 'addService']);
        // client api 
        Route::post('/client/upgrade', [FreelancerController::class, 'upgrade']);
        Route::post('/client/update', [FreelancerController::class, 'update']);

        // Route services
        // Route::post('/freelancer/services', [ServiceController::class, 'addService']);
        // Route::put('/freelancer/services/{service}', [ServiceController::class, 'updateService']);
        // Route::delete('/freelancer/services/{service}', [ServiceController::class, 'deleteService']);
        // Route::get('/freelancer/services', [ServiceController::class, 'listServices']); // List all services by the freelancer
        // Route::get('/freelancer/orders', [FreelancerController::class, 'listOrders']); // List all orders received
        // Route::post('/freelancer/orders/{order}/accept', [FreelancerController::class, 'acceptOrder']); // Accept an order
        // Route::post('/freelancer/orders/{order}/reject', [FreelancerController::class, 'rejectOrder']); // Reject an order
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

    // freelancer api 
    Route::get('/freelancer/profile/{id}', [FreelancerController::class, 'profile']);
    Route::post('/freelancer/updateProfile/{freelancer}', [FreelancerController::class, 'updateProfile']);
    // client api 
    Route::get('/client/profile/{id}', [ClientController::class, 'profile']);
    Route::post('/client/updateProfile/{client}', [ClientController::class, 'updateProfile']);

    //Route services
    // add service

    Route::post('/freelancer/services/{freelancer}', [ServiceController::class, 'addService']);

    // return all service
    Route::get('/freelancer/services', [ServiceController::class, 'listServices']); // List all services by the freelancer
    // return one service by id
    Route::get('/freelancer/services/{serivce}', [ServiceController::class, 'show']); // List all services by the freelancer
    // edit service 
    Route::put('/freelancer/services/{service}', [ServiceController::class, 'edit']);
    // delete service
    Route::delete('/freelancer/services/{service}', [ServiceController::class, 'deleteService']);

    /* Post Routes */

    // Get All Posts
    Route::get('/posts', [PostController::class, 'index']);
    // Get Post By id
    Route::get('/posts/{post}', [PostController::class, 'show']);
    // Create New Post
    Route::post('/posts/create', [PostController::class, 'store']);
    // Update Post
    Route::put('/posts/{post}', [PostController::class, 'update']);
    // Destroy Post
    Route::delete('/posts/{post}', [PostController::class, 'destroy']);
    // Get Proposals
    Route::get('/posts/{post}/proposals', [PostController::class, 'getProposals']);

    /* Category Routes */

    // Get All Category
    Route::get('/categories', [CategoryController::class, 'index']);
    // Add Category or Sub-Category
    Route::post('/categories', [CategoryController::class, 'store']);
    // Delete Category
    Route::delete('/categories/{category}', [CategoryController::class, 'destroy']);
});

// Route::get('/freelancer/orders', [FreelancerController::class, 'listOrders']); // List all orders received
    //Route::post('/freelancer/orders/{order}/accept', [FreelancerController::class, 'acceptOrder']); // Accept an order
    //Route::post('/freelancer/orders/{order}/reject', [FreelancerController::class, 'rejectOrder']); // Reject an order