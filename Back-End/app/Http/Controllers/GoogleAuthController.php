<?php

namespace App\Http\Controllers;

use App\Models\Auth\User;
use Illuminate\Http\Request;
use Laravel\Socialite\Facades\Socialite;


class GoogleAuthController extends Controller
{
    public function redirect()
    {
        return Socialite::driver("google")->redirect();
    }

    public function callback()
    {
        $googleUser = Socialite::driver("google")->user();
        // dd($googleUser);
        $user = User::updateOrCreate([
            'first_name' => $googleUser->user['given_name'],
            'last_name' => $googleUser->user['family_name'],
            'name' => $googleUser->user['name'],
            'type' => 'google-user',
            'birthdate' => '2002-08-02',
            'google_id' => $googleUser->user['id'],
            'email' => $googleUser->user['email'],
        ]);

        return response()->json($user);
    }
}
