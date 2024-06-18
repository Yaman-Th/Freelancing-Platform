<?php

namespace App\Models\Auth;

use Illuminate\Foundation\Auth\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Freelancer extends Model
{
    use HasFactory;

    protected $fillable =['user_id','personal_Overview','Wallet',"is_Avilable"];



    public function user()
    {
        return $this->belongsTo(User::class);
    }
   
}
