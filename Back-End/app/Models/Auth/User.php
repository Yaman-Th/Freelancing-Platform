<?php

namespace App\Models\Auth;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use App\Models\Auth\client;
use App\Models\Auth\Freelancer;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Contracts\Auth\CanResetPassword;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;


// use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable  implements CanResetPassword,MustVerifyEmail
{
    use HasApiTokens,HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'first_name',
        'last_name',
        'personal_image',
        "type",
        'email',
        'password',
        "is_active",
        'birthdate'
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

    public function freelancer()
    {
        return $this->hasOne(Freelancer::class);
    }

    public function client()
    {
        return $this->hasOne(client::class);
    }

    public function isFreelancer()
    {
        return $this->freelancer()->exists();
    }

    public function isClient()
    {
        return $this->client()->exists();
    }
}
