<?php

namespace App\Http\Controllers;

use App\Models\Auth\User;
use App\Models\Auth\EmailVerfcation;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Log;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Notification;
use Illuminate\Support\Facades\welcomNotification;
use App\Notifications\welcomNotfication;
use Illuminate\Support\Facades\Password;
use Illuminate\Auth\Events\PasswordReset;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Mail;
class AuthController extends Controller 
{


    /**
     * Register a new user
     */
    public function register(Request $request)
    {
        $request->validate([
        'First_Name'=> 'required|string|max:255|alpha',
        'Last_name'=> 'required|string|max:255|alpha',
        'personal_Image'=>'required|string',
        "type"=> 'required|string|max:255',
        'email'=> 'required|string|email|max:255|unique:users',
        'password'=> 'required|string|min:8|confirmed',
        "is_Active"=> 'required|boolean',
        'Birthdate'=> 'required|date'
        ]);

        $user = User::create([
        'First_Name'=> request('First_Name'),
        'Last_name'=> request('Last_name'),
        'personal_Image'=>request('personal_Image'),
        "type"=> request('type'),
        'email'=> request('email'),
        'password'=> Hash::make($request->password),
        "is_Active"=> request('is_Active'),
        'Birthdate'=>request('Birthdate')
        ]);
        $token = $user->createToken('myapptoken')->plainTextToken;

        // إنشاء رمز التحقق
        $token = Str::random(6);

        EmailVerfcation::create([
            'email' => $user->email,
            'token' => $token,
        ]);

        // إرسال الرمز عبر البريد الإلكتروني
        Mail::raw("Your verification code is: $token", function ($message) use ($user) {
            $message->to($user->email)
                    ->subject('Email Verification');
                });
                    
        return response()
        ->json([
            'message' => 'You have register successfully.',
            'user' => $user,
            'token' => $user->createToken('myapptoken')->plainTextToken,
        ]);
    //    $user->notify(new welcomNotfication());
        
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

        $request->user()->currentAccessToken()->delete();

        return response()->json('Logged out successfully');
    }

    public function deleteUser(User $user)
    {
        $user->delete();
        return response()->json(null, 204);
    }



    public function changePassword(Request $request)
    {
        $request->validate([
            'current_password' => 'required',
            'new_password' => 'required|min:8|confirmed',
        ]);

        $user = auth()->user();

        if (!Hash::check($request->current_password, $user->password)) {
            return response()->json(['current_password' => ['The provided password does not match our records.']], 400);
        }

        $user->password = bcrypt($request->new_password);
        // $user->save();

        
        return response()->json(['message' => 'Password changed successfully.'], 200);
    }











}

