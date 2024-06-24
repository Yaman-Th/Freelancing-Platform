<?php

namespace App\Models\Auth;

use App\Models\Skill;
use Illuminate\Foundation\Auth\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Freelancer extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'personal_overview',
        'personal_image',
        'wallet',
        'is_avilable'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
    public function skill()
    {
       return $this->belongsToMany(Skill::class, 'freelancer_skill', 'skill_id', 'freelancer_id');
    }
}
