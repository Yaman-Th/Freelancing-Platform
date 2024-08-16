<?php

namespace App\Http\Controllers;

use Throwable;
use App\Mail\myEmail;
use App\Models\Auth\User;
use App\Mail\reSet;
use App\Models\Auth\Client;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\Auth\Freelancer;
use Illuminate\Routing\Controller;
use Spatie\Permission\Models\Role;
use Illuminate\Support\Facades\Log;
use App\Models\Auth\EmailVerfcation;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use App\Notifications\welcomNotfication;
use Illuminate\Support\Facades\Password;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Notification;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\welcomNotification;
use Spatie\QueryBuilder\QueryBuilder;
use Spatie\QueryBuilder\AllowedFilter;

class AuthController extends Controller
{
    /**
     * Register a new user
     */
    public function register(Request $request)
    {
        try {
            $data = $request->validate([
                'first_name' => 'required|string|max:255|alpha',
                'last_name' => 'required|string|max:255|alpha',
                "type" => 'required|string|max:255',
                'email' => 'required|string|email|max:255|unique:users',
                'password' => 'required|string|min:8|confirmed',
                "is_active" => 'boolean',
                'birthdate' => 'required|date'
            ]);
            $data['name'] = $data['first_name'] . $data['last_name'];
            $user = User::create($data);

            if ($request->type === 'freelancer') {
                Freelancer::create([
                    'user_id' => $user->id
                ]);

                $freelancerRole = Role::query()->where('name', 'freelancer')->first();
                $user->assignRole($freelancerRole);

                $freelancerPermissions = $freelancerRole->permissions()->pluck('name')->toArray();
                $user->givePermissionTo($freelancerPermissions);
            }

            if ($request->type === 'client') {
                Client::create([
                    'user_id' => $user->id
                ]);
                $clientRole = Role::query()->where('name', 'client')->first();
                $user->assignRole($clientRole);

                $clientPermissions = $clientRole->permissions()->pluck('name')->toArray();
                $user->givePermissionTo($clientPermissions);
            }

            $user->load('roles', 'permissions');

            // إنشاء رمز التحقق
            $token = Str::random(6);

            EmailVerfcation::create([
                'email' => $user->email,
                'code' => $token,
            ]);

            // إرسال الرمز عبر البريد الإلكتروني
            Mail::to($user->email)->send(new myEmail($token));
        } catch (Throwable $th) {
            return response()->json([
                'error' => $th->getMessage()
            ], 500);
        }
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
            'code' => 'required|string',
        ]);

        $verification = EmailVerfcation::where('email', auth()->user()->email)
            ->where('code', $request->code)
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

    function index()
    {
        return response()->json(User::all());
    }


    public function sendResetPasswordCode(Request $request)
    {
        $user = User::where('email', $request->email)->first();

        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        $resetCode = Str::random(6);
        $user->password_reset_code = $resetCode;
        $user->save();

        // إرسال البريد الإلكتروني
        Mail::send('emails.reset_password', ['code' => $resetCode], function ($message) use ($user) {
            $message->to($user->email);
            $message->subject('Password Reset Code');
        });

        return response()->json(['message' => 'Reset code sent']);
    }

    public function resetPassword(Request $request)
    {
        $user = User::where('email', $request->email)
            ->where('password_reset_code', $request->code)
            ->first();

        if (!$user) {
            return response()->json(['message' => 'Invalid code or email'], 400);
        }

        $user->password = bcrypt($request->password);
        $user->password_reset_code = null; // مسح الرمز بعد الاستخدام
        $user->save();

        return response()->json(['message' => 'Password has been reset']);
    }
    public function Search(Request $request)
    {
        $filters = $request->only(['name', 'type', 'rating']);
        $users = User::filter($filters)->get();
        return response()->json($users);
    }
    public function myprofile()
    {
        $h = auth()->user();
        $user = User::find($h->id);
        if ($user->type == 'client') {
            $client = $user->client()->first()->id;
            $client = Client::find($client);
            return response()->json([
                'data user' => $user,
                'data else' => $client,
                'image_url' => url('storage/' . $client->personal_image),
            ]);
        } else if ($user->type === 'freelancer') {
            $freelancer = $user->freelancer()->first()->id;
            $free = Freelancer::find($freelancer);
            return response()->json([
                'data user' => $user,
                'data else' => $free,
                'image_url' => url('storage/'.$free->personal_image),
            ]);
        } else {
            return response()->json(['message ' => ' front are alwayes wrong']);
        }
    }
    public function alluser(){
    return response()->json(['users'=>User::all()]);        
    }
}
