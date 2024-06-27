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
use App\Http\Controllers\SkillController;
use App\Models\Skill;

// Public Routes
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);


// Routes for freelancer actions
Route::middleware('auth:sanctum')->group(function () {
    // user api
    // logout
    Route::post('/logout', [AuthController::class, 'logout']);

    Route::post('/change-password', [AuthController::class, 'changePassword']);

    Route::post('/verify-email', [AuthController::class, 'verfiyEmail']);

    // return profile by id
    Route::get('/freelancer/profile/{freelancer}', [FreelancerController::class, 'show']);

    // return prfile
    Route::get('/client/profile/{id}', [ClientController::class, 'profile']);

    // freelancer api 

    // return profile
    Route::middleware('role:freelancer')->group(function () {
        // return own profile 
        Route::get('/freelancer/myprofile', [FreelancerController::class, 'myprofile']);
        // update prfile
        Route::post('/freelancer/updateProfile', [FreelancerController::class, 'updateProfile']);

        Route::post('/freelancer/services', [ServiceController::class, 'addService']);

        // return all service
        Route::get('/freelancer/services', [ServiceController::class, 'listServices']); // List all services by the freelancer
        // return one service by id
        Route::get('/freelancer/services/{serivce}', [ServiceController::class, 'show']); // List all services by the freelancer
        // edit service 
        Route::put('/freelancer/services/{service}', [ServiceController::class, 'edit']);
        // delete service
        Route::delete('/freelancer/services/{serviceId}', [ServiceController::class, 'destroy']);
    });
    // client api 
    Route::middleware('role:client')->group(function () {


        //update Prfile
        Route::post('/client/updateProfile/{client}', [ClientController::class, 'updateProfile']);
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
    

        /*  order  */
        
    
    
    });

    Route::middleware('role:admin')->group(function () {

        /* Category Routes */

        // Get All Category
        Route::get('/categories', [CategoryController::class, 'index']);
        // Add Category or Sub-Category
        Route::post('/categories', [CategoryController::class, 'store']);
        // Delete Category
        Route::delete('/categories/{category}', [CategoryController::class, 'destroy']);

        /*Skill API */
        // create Skill
        Route::post('/Skill', [SkillController::class, 'create']);

        Route::post('/addSkill', [SkillController::class, 'addSkill']);
        //get all
        Route::get('/Skill', [SkillController::class, 'index']);
        //
        Route::delete('/Skill', [SkillController::class, 'destroy']);
    });
});
