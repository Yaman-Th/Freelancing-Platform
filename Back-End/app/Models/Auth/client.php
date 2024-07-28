<?php

namespace App\Models\Auth;

use App\Models\Contract;
use App\Models\Post;
use App\Models\ServiceOrder;
use App\Models\Team;
use Illuminate\Foundation\Auth\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Client extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'personal_overview',
        'personal_image',
        'wallet',
        'is_avilable',
        'Rating',
        'total_spend',
        'total_review',
        'total_project',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function posts()
    {
        return $this->hasMany(Post::class);
    }
    public function contract()
    {
        return $this->hasMany(Contract::class);
    }
    public function teams()
    {
        return $this->hasMany(Team::class);
    }
    public function serviceOrders()
    {
        return $this->hasMany(ServiceOrder::class);
    }
}
