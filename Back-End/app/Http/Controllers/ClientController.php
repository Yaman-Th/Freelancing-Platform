<?php

namespace App\Http\Controllers;

use App\Models\Auth\User;
use App\Models\Auth\client;
use Illuminate\Http\Request;
use Ramsey\Uuid\Type\Integer;
use Illuminate\Support\Facades\DB;
use App\Http\Requests\StoreclientRequest;
use App\Http\Requests\UpdateclientRequest;

class ClientController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function upgrade(Request $request, client $client,User $user)
    {
        $user = client::create([
            'user_id' => request("user_id"),
            'personal_Overview' => request("personal_Overview"),
            'Wallet' => 0,
            'is_Avilable' => true

        ]);
        
        return response()->json(['message' => 'Account is Client now']);
    }
    
    /**
     * profile
     */
    // all info
    public function profile(Integer $id)
    {
        { $client = DB::table('clinet')
            ->join('users', 'client.id', '=', 'client.user_id') // Assuming freelancers table has user_id column
            ->select('client.*', 'users.*')
            ->where('client.id', $id)
            ->first();
            return response()->json($client);
        }    }

    // update info 
    public function update(Request $request, client $client)
    {
        $newData=request()->valdate([
            "personal_Overview"=>"max:255|string",
            "is_Avilable"=>"boolean"
        ]);
        $client->update($newData);
        
        return response()->json($client);

    }
}
