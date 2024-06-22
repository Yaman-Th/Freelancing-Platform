<?php

namespace App\Models\Auth;

use Illuminate\Foundation\Auth\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class client extends Model
{
    use HasFactory;

    protected $fillable = ['user_id', 'personal_overview', 'wallet', 'is_avilable'];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
