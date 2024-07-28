<?php

namespace App\Models;

use App\Models\Auth\Client;
use App\Models\Auth\Freelancer;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Team extends Model
{
    protected $fillable = ['client_id', 'name'];

    public function client()
    {
        return $this->belongsTo(Client::class);
    }

    public function invitation()
    {
        return $this->hasMany(Invitation::class);
    }

    public function freelancers()
    {
        return $this->belongsToMany(Freelancer::class, 'invitation')->wherePivot('status', 'accepted');
    }
}
