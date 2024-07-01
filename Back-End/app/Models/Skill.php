<?php

namespace App\Models;

use App\Models\Auth\Freelancer;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Skill extends Model
{
  use HasFactory;

  protected $fillable = [
    'name'
  ];
  public function freelancer()
  {
    return  $this->belongsToMany(Freelancer::class, 'freelancer_skill', 'freelancer_id', 'skill_id');
  }

  public function post()
  {
    return $this->belongsToMany(Post::class);
  }
}
