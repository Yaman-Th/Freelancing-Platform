<?php

namespace App\Models;

use App\Models\Auth\Client;
use App\Models\Proposal;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    use HasFactory;

    protected $fillable = [
        'client_id',
        'category_id',
        'team_id',
        'title',
        'description',
        'type',
        'budget',
        'deadline',
    ];

    public function client()
    {
        return $this->belongsTo(Client::class);
    }

    public function proposals()
    {
        return $this->hasMany(Proposal::class);
    }

    public function skills()
    {
        return $this->belongsToMany(Skill::class);
    }

    public function isProject()
    {
        return $this->type === 'project';
    }

    public function isJob()
    {
        return $this->type === 'job';
    }
}
