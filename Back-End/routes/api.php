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
use App\Http\Controllers\ContractController;
use App\Http\Controllers\FreelancerController;
use App\Http\Controllers\paymentController;
use App\Http\Controllers\ProposalController;
use App\Http\Controllers\ServiceOrderController;
use App\Http\Controllers\SkillController;
use App\Http\Controllers\TeamController;
use App\Models\ServiceOrder;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;


// Public Routes
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::get('/pay',[paymentController::class,'pay']);

Route::middleware('auth:sanctum')->group(function () {

    Route::post('/client/team',[TeamController::class,'create']);
    Route::post('/client/sendRequest',[TeamController::class,'sendRequest']);

    Route::post('/client/addMember',[TeamController::class,'addMember']);





    Route::get('/buy', function (Request $request) {
        $checkout = $request->user()->checkout(['pri_deluxe_album',2]);
     
        return response()->json( ['checkout' => $checkout]);
    });

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
        // return own profile 
        Route::get('/freelancer/myprofile', [FreelancerController::class, 'myprofile']);
        // update prfile
        Route::post('/freelancer/updateProfile', [FreelancerController::class, 'update']);
        // Add New Service
        Route::post('/freelancer/services', [ServiceController::class, 'addService']);
        // return all service
        Route::get('/freelancer/services', [ServiceController::class, 'listServices']); // List all services by the freelancer
        // return one service by id
        Route::get('/freelancer/services/{serivce}', [ServiceController::class, 'show']); // List all services by the freelancer
        // edit service 
        Route::put('/freelancer/services/{service}', [ServiceController::class, 'edit']);
        // delete service
        Route::delete('/freelancer/services/{serviceId}', [ServiceController::class, 'destroy']);

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

        // return profile by id
        Route::get('/freelancer/profile/{freelancer}', [FreelancerController::class, 'show']);
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


    Route::post('/order',[ServiceOrderController::class,'create']);
    
    Route::get('/bla/{serviceorder_id}',[ContractController::class,'createContractService']);
    
    Route::get('/order/{serviceOrder}',[ServiceOrderController::class,'show']);



Route::get('/bla/bla/{serviceOrder}',[paymentController::class,'pay']);














});
