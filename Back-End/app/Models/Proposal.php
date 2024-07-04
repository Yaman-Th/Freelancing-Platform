<?php

namespace App\Models;

use App\Models\Auth\Freelancer;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Post;

class Proposal extends Model
{
    use HasFactory;

    protected $fillable = [
        'post_id',
        'freelancer_id',
        'comment',
        'status',
        'date'
    ];

    public function post()
    {
        return $this->belongsTo(Post::class);
    }

    public function freelancer()
    {
        return $this->belongsTo(Freelancer::class);
    }
}
