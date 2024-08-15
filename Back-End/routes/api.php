<?php

use Spatie\Permission\Models\Role;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use Spatie\QueryBuilder\QueryBuilder;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\TeamController;
use Spatie\Permission\Models\Permission;
use App\Http\Controllers\SkillController;
use App\Http\Controllers\ClientController;
use App\Http\Controllers\paymentController;
use App\Http\Controllers\ServiceController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\ContractController;
use App\Http\Controllers\ProposalController;
use App\Http\Controllers\FreelancerController;
use App\Http\Controllers\LinksController;
use App\Http\Controllers\RatingController;
use App\Http\Controllers\ServiceOrderController;
use App\Http\Controllers\translateController;
use App\Http\Controllers\vendor\Chatify\Api\MessagesController;

// Public Routes

Route::post('/register', [AuthController::class, 'register']);

Route::post('/login', [AuthController::class, 'login']);

Route::post('/sendresetpassword', [AuthController::class, 'sendResetPasswordCode']);

Route::post('/resetpassword', [AuthController::class, 'resetPassword']);

Route::get('/translate/{type}/{lang}/{id}', [translateController::class, 'getTranslatedData']);

// get  &  Search  are public
Route::get('/users/search', [AuthController::class, 'Search']);

// Route::get('/services/search', [ServiceController::class, 'Search']);

Route::get('/categories/search', [CategoryController::class, 'Search']);

Route::get('/freelancers/search-by-skills', [FreelancerController::class, 'searchBySkills']);

Route::get('/skill/search', [SkillController::class, 'Search']);

// return profile client by id
Route::get('/client/profile/{id}', [ClientController::class, 'profile']);

// return profile freelancer by id
Route::get('/freelancer/profile/{id}', [FreelancerController::class, 'show']);


/* Skill Routes */
Route::get('/skills', [SkillController::class, 'list']);

Route::get('/skills/{skill}', [SkillController::class, 'show']); // الحصول على مهارة واحدة
// create Skill
Route::post('/skills', [SkillController::class, 'create']); // إنشاء مهارة جديدة

Route::delete('/skills', [SkillController::class, 'destroy']); // حذف مهارة


//////////////////////////////////////

// category 
Route::get('/categories', [CategoryController::class, 'index']);

Route::get('/parentcategories', [CategoryController::class, 'getParentCategory']);

Route::get('/subcategories', [CategoryController::class, 'getsubCategory']);

//get all
Route::get('/Skill', [SkillController::class, 'index']);

// return all service
Route::get('services', [ServiceController::class, 'index']);
// return one service by id
Route::get('service/{id}', [ServiceController::class, 'show']);

// Get All Posts of Client
Route::get('/allpost', [PostController::class, 'index']);
// Get Post By id
Route::get('p/{post}', [PostController::class, 'show']);
// get posts for spesfic client
Route::get('/post/{clientId}', [PostController::class, 'getpostsbyid']);

Route::get('/order/{serviceOrder}', [ServiceOrderController::class, 'show']);

Route::post('/addOrder', [ServiceOrderController::class, 'create']);


Route::middleware('auth:sanctum')->group(function () {

    Route::get('/team/myinvitation/{name}', [TeamController::class, 'teamInvitation']);


    Route::get('/myservices', [ServiceController::class, 'myservice']);

    // Logout
    Route::post('/logout', [AuthController::class, 'logout']);
    // Password Reset
    Route::post('/change-password', [AuthController::class, 'changePassword']);
    // Email Verification
    Route::post('/verify-email', [AuthController::class, 'verfiyEmail']);

    ///// teams/////

    Route::post('client/teams', [TeamController::class, 'create']);
    Route::post('client/teams/requests', [TeamController::class, 'sendRequest']);
    Route::patch('freelancer/team/responseinvintation/{id}', [TeamController::class, 'handleRequest']);
    Route::get('clients/myteams', [TeamController::class, 'getClientTeams']);
    Route::get('freelancer/myteams', [TeamController::class, 'getAuthenticatedFreelancerTeams']);
    Route::get('team/{teamId}/members', [TeamController::class, 'getmembers']);
    Route::delete('team/{name}', [TeamController::class, 'destroy']);


    /////////////

    ////////// ratings////////
    Route::post('rating', [RatingController::class, 'store']);
    Route::get('rating', [RatingController::class, 'index']);
    Route::get('rating/{id}', [RatingController::class, 'show']);
    Route::put('rating/{id}', [RatingController::class, 'update']);
    Route::delete('rating/{id}', [RatingController::class, 'destroy']);
    Route::get('ratings/service/{serviceId}', [RatingController::class, 'getServiceRatings'])->name('ratings.getServiceRatings');
    Route::get('ratings/post/{postId}', [RatingController::class, 'getPostRatings'])->name('ratings.getPostRatings');
    Route::get('ratings/user/{userId}', [RatingController::class, 'getUserRatings'])->name('ratings.getUserRatings');

    ////////////

    // FreelancerRoutes  
    Route::middleware('role:freelancer')->group(function () {

        // return own profile 
        Route::get('/freelancer/myprofile', [FreelancerController::class, 'myprofile']);

        // update profile
        Route::post('/freelancer/updateProfile', [FreelancerController::class, 'update']);
        // Accept ServiceOrder
        Route::put('/orders/{serviceOrder}/approve', [ServiceOrderController::class, 'approve']);
        // ->can('updateStatus', 'serviceOrder');
        // Reject ServiceOrder
        Route::put('/orders/{serviceOrder}/reject', [ServiceOrderController::class, 'reject']);
        // ->can('updateStatus', 'serviceOrder');
        Route::get('/getorderfreelancer', [ServiceOrderController::class, 'getOrderFreelancer']);




        // مسارات لإضافة وإزالة مهارات الفريلانسر
        Route::post('/freelancers/skills', [SkillController::class, 'addSkill']); // إضافة مهارة لفريلانسر
        Route::delete('/freelancers/{freelancerId}/skills', [SkillController::class, 'removeSkill']); // إزالة مهارة من فريلانسر
        //////////////////////

        /* Service Route */
        Route::prefix('services')->group(function () {
            // Add New Service
            Route::post('/', [ServiceController::class, 'store']);
            // ->middleware('can:service.create');

            // edit service 
            Route::put('/{service}', [ServiceController::class, 'edit'])
                ->can('update', 'service');
            // delete service
            Route::delete('/{service}', [ServiceController::class, 'destroy'])
                ->can('delete', 'service');
        });

        // approve the order
        Route::put('orders/{orderId}/approve', [ServiceOrderController::class, 'approve']);

        /* Proposal Routes */
        Route::prefix('proposals')->group(function () {
            // Get All Proposals of Freelacner
            Route::get('/', [ProposalController::class, 'index']);
            // Store New Proposal
            Route::post('/', [ProposalController::class, 'store']);
            // ->middleware('can:proposal.create');
            // Get Proposal By id
            Route::get('/{proposal}', [ProposalController::class, 'show']);
            // Update Proposal
            Route::put('/{proposal}', [ProposalController::class, 'update']);
            // ->can('update', 'proposal');
            // Destroy Proposal
            Route::delete('/{proposal}', [ProposalController::class, 'destroy']);
            // ->can('delete', 'proposal');
        });
    });

    // ClientRoutes 
    Route::middleware('role:client')->group(function () {

        //update profile
        Route::post('/client/updateProfile', [ClientController::class, 'updateProfile']);

        Route::get('/client/myprofile', [ClientController::class, 'myProfile']);

        Route::get('/client/myorders', [ServiceOrderController::class, 'getOrderClient']);

        // get my post

        /* Post Routes */
        Route::prefix('posts')->group(function () {

            // Create New Post
            Route::post('/', [PostController::class, 'store']);
            // ->can('create', 'post');
            // Update Post
            Route::put('/{post}', [PostController::class, 'update']);
            // ->can('update', 'post');
            // Destroy Post
            Route::delete('/{post}', [PostController::class, 'destroy']);
            // ->can('delete', 'post');
            // Get Proposals
            Route::get('/{post}/proposals', [PostController::class, 'getProposals']);

            Route::get('/mypost', [PostController::class, 'getmypost']);
        });

        /* Proposal Routes */
        // Accept Proposal
        Route::put('/proposals/{proposal}/accept', [ProposalController::class, 'acceptProposal']);
        // ->can('updateStatus', 'proposal');
        // Reject Proposal
        Route::put('/proposals/{proposal}/reject', [ProposalController::class, 'rejectProposal']);
        // ->can('updateStatus', 'proposal');

        // payments Route
        Route::get('payment/info/{contractId}', [paymentController::class, 'getPaymentDetails']);

        Route::post('payment/pay', [paymentController::class, 'processPayment']);

        /* ServiceOrder Routes */
        Route::prefix('orders')->group(function () {
            // Get All Service Orders
            Route::get('/', [ServiceOrderController::class, 'index']);
            // Create New Service Order
            Route::post('/', [ServiceOrderController::class, 'create'])
                ->middleware('can:order.create');
            // Get Service Order By id
            Route::get('/{serviceOrder}', [ServiceOrderController::class, 'show']);
            // Destroy ServiceOrder
            Route::delete('/{serviceOrder}', [ServiceOrderController::class, 'destroy'])
                ->can('delete', 'serviceOrder');
            Route::put('/complete/{orderId}', [ServiceOrderController::class, 'completeOrder']);
            // Get Service Order By CLient.
            Route::get('/getorderclient', [ServiceOrderController::class, 'getOrderClient']);
        });
    });

    // AdminRoutes
    Route::middleware('role:admin')->group(function () {

        /* Category Routes */
        // Add Category or Sub-Category
        Route::post('/categories', [CategoryController::class, 'store']);
        // Delete Category
        Route::delete('/categories/{category}', [CategoryController::class, 'destroy']);
    });

    //////////////Links///////////

    Route::get('Links/mylinks', [LinksController::class, 'index']);

    Route::post('Links/add', [LinksController::class, 'create']);

    Route::delete('Links/{links}', [LinksController::class, 'delete']);
    ////////////////////////////////////////


    ////////////chat*////////

    Route::post('/sendMessage', [MessagesController::class, 'send'])->name('api.send.message');

    Route::post('/fetchMessages', [MessagesController::class, 'fetch'])->name('api.fetch.messages');

    Route::post('/idInfo', [MessagesController::class, 'idFetchData']);

    Route::post('/pusher/auth', [MessagesController::class, 'pusherAuth']);

    // Route::get('/index/{channel_id?}', [MessagesController::class, 'index']);

    Route::get('/getContacts', [MessagesController::class, 'getContacts']);

    // Route::post('/makeSeen', [MessagesController::class,'seen'])->name('api.messages.seen');
    // /getchannelid
    Route::post('/getchannelid', [MessagesController::class, 'getChannelId']);

    Route::post('/createGroupChat', [MessagesController::class, 'createGroupChat']);

    Route::get('/search', [MessagesController::class, 'search'])->name('api.search');

    Route::get('/pusherAuth', [MessagesController::class, 'pusherAuth']);

    Route::post('/getChannelId', [MessagesController::class, 'getChannelId']);

    /////////////////////////////////////////////////////////////////////////////////////////////

    Route::get('/calculateMoney', [paymentController::class, 'calculateMoney']);

    Route::get('/totalProject', [PostController::class, 'totalProject']);

    Route::get('/totalService', [ServiceController::class, 'totalService']);

    Route::get('/image/{getImageUrl}', [ServiceController::class, 'getImageData']);

    Route::get('/my',[AuthController::class,'myprofile']);
});
