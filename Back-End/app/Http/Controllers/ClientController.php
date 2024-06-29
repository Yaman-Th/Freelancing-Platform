<?php

namespace App\Http\Controllers;

use App\Models\Auth\User;
use App\Models\Auth\Client;
use Illuminate\Http\Request;
use Ramsey\Uuid\Type\Integer;
use Illuminate\Support\Facades\DB;
use App\Http\Requests\StoreclientRequest;
use App\Http\Requests\UpdateclientRequest;
use Illuminate\Validation\ValidationException;

class ClientController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function updateProfile(Request $request, Client $client)
    {
        try {
            $request->validate([
                'personal_image' => 'sometimes|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
                'personal_overview' => 'sometimes|string',
            ]);
    
            if ($request->hasFile('personal_image')) {
                $personal_image = $request->file('personal_image')->store('personal_images');
                $client->update([
                    'personal_image' => $personal_image,
                    'personal_overview' => $request->personal_overview,
                ]);
            } else {
                $client->update([
                    'personal_overview' => $request->personal_overview
                ]);
            }
        } catch (ValidationException $exception) {
            return response()->json([
                'message' => 'Validation Error',
                'errors' => $exception->errors()
            ], 422);
        }
    
        return response()->json(['message' => 'Update Successfully']);
    }
    
        /**
         * profile
         */
        // all info
        public function profile(Client $client)
        //    SELECT * FROM client f JOIN users u on u.id=f.id WHERE f.id=3
        {
            $clientinfo = DB::table('client')
                ->join('users', 'users.id', '=', 'client.user_id') // Assuming client table has user_id column
                ->select('client.*', 'users.*')
                ->where('client.id', $client->id)
                ->first();
            // $Skill
            return response()->json($clientinfo);
        }

    
}
