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
use App\Http\Controllers\ProposalController;
use App\Http\Controllers\ServiceOrderController;
use App\Http\Controllers\SkillController;
use App\Models\Service;
use App\Models\ServiceOrder;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;


// Public Routes
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);


Route::middleware('auth:sanctum')->group(function () {


    Route::post('/addOrder', [ServiceOrderController::class, 'create']);



    // Logout
    Route::post('/logout', [AuthController::class, 'logout']);
    // Password Reset
    Route::post('/change-password', [AuthController::class, 'changePassword']);
    // Email Verification
    Route::post('/verify-email', [AuthController::class, 'verfiyEmail']);

    // return profile
    Route::get('/client/profile/{id}', [ClientController::class, 'profile']);

    // FreelancerRoutes  
    Route::middleware('role:freelancer')->group(function () {

        // return profile by id
        Route::get('/freelancer/profile/{freelancer}', [FreelancerController::class, 'show']);
        // return own profile 
        Route::get('/freelancer/myprofile', [FreelancerController::class, 'myprofile']);
        // update prfile
        Route::post('/freelancer/updateProfile', [FreelancerController::class, 'update']);

        // Accept ServiceOrder
        Route::put('/orders/{serviceOrder}/accept', [ServiceOrderController::class, 'acceptOrder'])
            ->can('updateStatus', 'serviceOrder');
        // Reject ServiceOrder
        Route::put('/orders/{serviceOrder}/reject', [ServiceOrderController::class, 'rejectOrder'])
            ->can('updateStatus', 'serviceOrder');


        /* Service Route */
        Route::prefix('services')->group(function () {
            // Add New Service
            Route::post('/', [ServiceController::class, 'store'])
                ->middleware('can:service.create');
            // return all service
            Route::get('/', [ServiceController::class, 'index']);
            // return one service by id
            Route::get('/{service}', [ServiceController::class, 'show']);
            // edit service 
            Route::put('/{service}', [ServiceController::class, 'edit'])
                ->can('update', 'service');
            // delete service
            Route::delete('/{service}', [ServiceController::class, 'destroy'])
                ->can('delete', 'service');
        });

        /* Proposal Routes */
        Route::prefix('proposals')->group(function () {
            // Get All Proposals of Freelacner
            Route::get('/', [ProposalController::class, 'index']);
            // Store New Proposal
            Route::post('/', [ProposalController::class, 'store'])
                ->middleware('can:proposal.create');
            // Get Proposal By id
            Route::get('/{proposal}', [ProposalController::class, 'show']);
            // Update Proposal
            Route::put('/{proposal}', [ProposalController::class, 'update'])
                ->can('update', 'proposal');
            // Destroy Proposal
            Route::delete('/{proposal}', [ProposalController::class, 'destroy'])
                ->can('delete', 'proposal');
        });
    });

    // ClientRoutes 
    Route::middleware('role:client')->group(function () {

        //update Prfile
        Route::post('/client/updateProfile/{client}', [ClientController::class, 'updateProfile']);

        /* Post Routes */
        Route::prefix('posts')->group(function () {
            // Get All Posts of Client
            Route::get('/', [PostController::class, 'index']);
            // Get Post By id
            Route::get('/{post}', [PostController::class, 'show']);
            // Create New Post
            Route::post('/', [PostController::class, 'store'])
                ->can('create', 'post');
            // Update Post
            Route::put('/{post}', [PostController::class, 'update'])
                ->can('update', 'post');
            // Destroy Post
            Route::delete('/{post}', [PostController::class, 'destroy'])
                ->can('delete', 'post');
            // Get Proposals
            Route::get('/{post}/proposals', [PostController::class, 'getProposals']);
        });

        /* Proposal Routes */
        // Accept Proposal
        Route::put('/proposals/{proposal}/accept', [ProposalController::class, 'acceptProposal'])
            ->can('updateStatus', 'proposal');
        // Reject Proposal
        Route::put('/proposals/{proposal}/reject', [ProposalController::class, 'rejectProposal'])
            ->can('updateStatus', 'proposal');

        /* ServiceOrder Routes */
        Route::prefix('orders')->group(function () {
            // Get All Service Orders
            Route::get('/', [ServiceOrderController::class, 'index']);
            // Create New Service Order
            Route::post('/', [ServiceOrderController::class, 'store'])
                ->middleware('can:order.create');
            // Get Service Order By id
            Route::get('/{serviceOrder}', [ServiceOrderController::class, 'show']);
            // Destroy ServiceOrder
            Route::delete('/{serviceOrder}', [ServiceOrderController::class, 'destroy'])
                ->can('delete', 'serviceOrder');
            // Get Service Order By CLient.
            // Route::get('/getOrderClient', [ServiceOrderController::class, 'getOrderClient']);
        });
    });

    // AdminRoutes
    Route::middleware('role:admin')->group(function () {

        /* Category Routes */
        // Get All Category
        Route::get('/categories', [CategoryController::class, 'index']);
        // Add Category or Sub-Category
        Route::post('/categories', [CategoryController::class, 'store']);
        // Delete Category
        Route::delete('/categories/{category}', [CategoryController::class, 'destroy']);

        /* Skill Routes */
        // create Skill
        Route::post('/Skill', [SkillController::class, 'create']);

        Route::post('/addSkill', [SkillController::class, 'addSkill']);
        //get all
        Route::get('/Skill', [SkillController::class, 'index']);
        //
        Route::delete('/Skill', [SkillController::class, 'destroy']);
    });
});
