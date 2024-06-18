<?php

namespace App\Http\Controllers;

use App\Http\Requests;
use App\Models\Auth\User;
use App\Models\Auth\users;
use Ramsey\Uuid\Type\Integer;
use App\Models\Auth\Freelancer;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Request;
use App\Http\Requests\UpdateFreelancerRequest;

class FreelancerController extends Controller
{
    // to make the user Freelancer
    public function upgrade(Request $request, Freelancer $freelancer,User $user)
    {
        $user = Freelancer::create([
            'user_id' => request("user_id"),
            'personal_Overview' => request("personal_Overview"),
            'Wallet' => 0,
            'is_Avilable' => true

        ]);
        
        return response()->json(['message' => 'Account is Freelancer now']);
    }
    
    /**
     * profile
     */
    // all info
    public function profile($id)
    //    SELECT * FROM freelancers f JOIN users u on u.id=f.id WHERE f.id=3
       { $freelancer = DB::table('freelancers')
        ->join('users', 'users.id', '=', 'freelancers.user_id') // Assuming freelancers table has user_id column
        ->select('freelancers.*', 'users.*')
        ->where('freelancers.id', $id)
        ->first();
        return response()->json($freelancer);
    }

    // update info 
    public function update(UpdateFreelancerRequest $request, Freelancer $freelancer)
    {
        $newData=request()->valdate([
            "personal_Overview"=>"max:255|string",
            "is_Avilable"=>"boolean"
        ]);
        $freelancer->update($newData);
        
        return response()->json($$freelancer);

    }
    
    public function addService(){

    }
   
}
