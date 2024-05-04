<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Log;
use Illuminate\Routing\Controller;


class AuthController extends Controller
{
    /**
     * Register a new user
     */
    public function register(Request $request)
    {
        $request->validate([
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8|confirmed',
        ]);

        $user = User::create([
            'name'=>request('name'),
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);
        $token = $user->createToken('myapptoken')->plainTextToken;

        $response = [
            'user' => $user,
            'token' => $token
        ];

        return response($response, 201);
    }


    /**
     * Log in an existing user
     */
    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',

        ]);

        $user = User::where('email', $request->email)->first();



        if (!$user || !Hash::check($request->password, $user->password)) {
            throw ValidationException::withMessages([
                'email' => ['The provided credentials are incorrect.'],
            ]);
        }

        return response()
            ->json([
                'message' => 'You have logged in successfully.',
                'user' => $user,
                'token' => $user->createToken('myapptoken')->plainTextToken,
            ]);
    }


    /**
     * Log out the authenticated user
     */
    public function logout(Request $request)
    {


        // Log::info($request->user());
        // Log::info($request->header('Authorization'));

        $request->user()->currentAccessToken()->delete();

        return response()->json('Logged out successfully');
    }

    public function deleteUser(User $user)
    {
        $user->delete();
        return response()->json(null, 204);
    }
}
