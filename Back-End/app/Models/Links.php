<?php

namespace App\Models;

use App\Models\Auth\User;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Links extends Model
{
    use HasFactory;
    protected $fillable=[
        'links',
        'type',
        'user_id'
    ];

    public function user(){
        return $this->belongsTo(User::class);
    }
}
