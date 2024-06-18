<?php

namespace App\Models\Auth;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EmailVerfcation extends Model
{
    use HasFactory;

    protected $fillable = ['email', 'token'];
}