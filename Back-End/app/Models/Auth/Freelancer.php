<?php

namespace App\Models\Auth;

use App\Models\Skill;
use App\Models\Service;
use App\Models\Contract;
use App\Models\Proposal;
// use Illuminate\Foundation\Auth\User;
use App\Models\Auth\User;
use App\Models\Invitation;
use App\Models\Team;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Freelancer extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'personal_overview',
        'wallet',
        "is_avilable",
        'personal_image',
        'Rating',
        'total_project',
        'total_review',
        'total_project',
    ];


    public function user()
    {
        return $this->belongsTo(User::class);
    }
    public function freelancers()
{
    return $this->belongsToMany(Freelancer::class, 'freelancer_skill', 'skill_id', 'freelancer_id')->withTimestamps();
}
    public function propsals()
    {
        return $this->hasMany(Proposal::class);
    }
    public function service()
    {
        return $this->hasMany(Service::class);
    }
    public function contract()
    {
        return $this->hasMany(Contract::class);
    }

    public function invitation()
    {
        return $this->hasMany(Invitation::class);
    }
    public function skills()
    {
        return $this->belongsToMany(Skill::class, 'freelancer_skill', 'freelancer_id', 'skill_id');
    }
    public function teams()
    {
        return $this->belongsToMany(Team::class, 'invitations')->wherePivot('status', 'accepted');
    }
}
