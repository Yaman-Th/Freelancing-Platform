<?php

namespace App\Models;

use App\Models\Auth\Client;
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

    public function isProject()
    {
        return $this->type === 'project';
    }

    public function isJob()
    {
        return $this->type === 'job';
    }
}
