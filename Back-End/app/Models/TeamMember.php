<?php

namespace App\Models;

use App\Models\Auth\Freelancer;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TeamMember extends Model
{
    use HasFactory;

    protected $fillable = [
        'team_id',
        'freelancer_id'
    ];

    public function freelancer(){
        return $this->belongsTo(Freelancer::class);
    }
    public function team(){
        return $this->belongsTo(Team::class);
    }
}
