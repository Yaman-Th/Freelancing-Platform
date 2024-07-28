<?php

namespace App\Models;

use App\Models\Auth\Freelancer;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Invitation extends Model
{
    use HasFactory;

    protected $fillable = ['team_id', 'freelancer_id', 'status'];

    public function team()
    {
        return $this->belongsTo(Team::class);
    }

    public function freelancer()
    {
        return $this->belongsTo(Freelancer::class);
    }
}
