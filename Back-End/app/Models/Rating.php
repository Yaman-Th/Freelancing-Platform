<?php

namespace App\Models;

use App\Models\Auth\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Rating extends Model
{
    use HasFactory;

    protected $fillable = [
        'service_order_id',
        'post_id',
        'rater_id',
        'ratee_id',
        'score',
        'comment',
    ];

    public function service_order()
    {
        return $this->belongsTo(ServiceOrder::class);
    }

    public function post()
    {
        return $this->belongsTo(Post::class);
    }

    public function rater()
    {
        return $this->belongsTo(User::class,'rater_id');
    }

    public function ratee()
    {
        return $this->belongsTo(User::class,'ratee_id');
    }
}
