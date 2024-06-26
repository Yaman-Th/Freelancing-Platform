<?php

namespace App\Http\Controllers;

use App\Mail\myEmail;
use App\Models\Auth\Client;
use App\Models\Auth\User;
use App\Models\Auth\EmailVerfcation;
use App\Models\Auth\Freelancer;
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
        $data = $request->validate([
            'first_name' => 'required|string|max:255|alpha',
            'last_name' => 'required|string|max:255|alpha',
            "type" => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8|confirmed',
            "is_active" => 'boolean',
            'birthdate' => 'required|date'
        ]);
        $user = User::create($data);

        if ($request->type === 'freelancer') {
            Freelancer::create([
                'user_id' => $user->id
            ]);
            $user->assignRole('freelancer');
        }

        if ($request->type === 'client') {
            Client::create([
                'user_id' => $user->id
            ]);
            $user->assignRole('client');
        }

        // إنشاء رمز التحقق
        $token = Str::random(6);

        EmailVerfcation::create([
            'email' => $user->email,
            'token' => $token,
        ]);

        // إرسال الرمز عبر البريد الإلكتروني
        Mail::to($user->email)->send(new myEmail($token));

        return response()
            ->json([
                'message' => 'You have registered successfully.',
                'user' => $user,
                'token' => $user->createToken('myapptoken')->plainTextToken,
            ]);
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
        $user->save();

        return response()->json(['message' => 'Password changed successfully.'], 200);
    }


    public function verfiyEmail(Request $request)
    {
        $request->validate([
            'token' => 'required|string',
        ]);

        $verification = EmailVerfcation::where('email', auth()->user()->email)
            ->where('token', $request->token)
            ->first();

        if ($verification) {
            $user = User::where('email', auth()->user()->email)->first();
            $user->email_verified_at = now();
            $user->save();

            // حذف سجل التحقق بعد التحقق الناجح
            $verification->delete();

            return response()->json(['message' => 'Email verified successfully.']);
        }

        return response()->json(['message' => 'Invalid verification code.'], 400);
    }
}
