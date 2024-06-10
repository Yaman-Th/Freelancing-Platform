<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Freelancer extends Model
{
    
    
    use HasFactory;
    
    protected $fillable=[
        'personal_Overview',
        "Wallet",
        "is_Avilable"];

}
