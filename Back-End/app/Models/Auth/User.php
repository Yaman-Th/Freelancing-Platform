<?php

namespace App\Models\Auth;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use App\Models\Auth\Client;
use App\Models\Auth\Freelancer;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Contracts\Auth\CanResetPassword;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Laravel\Paddle\Billable;
use Spatie\Permission\Traits\HasRoles;

// use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable  implements CanResetPassword, MustVerifyEmail
{
    use HasApiTokens, HasFactory, Notifiable, HasRoles,Billable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $guard_name = 'web';

    protected $fillable = [
        'name',
        'first_name',
        'last_name',
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
        return $this->hasOne(Client::class);
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
