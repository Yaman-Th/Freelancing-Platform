<?php

namespace App\Models;

use App\Models\Auth\Freelancer;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Skill extends Model
{
    use HasFactory;

    protected $fillable = ['name'];


    public function freelancer()
    {
        return $this->belongsToMany(Freelancer::class, 'freelancer_skill', 'skill_id', 'freelancer_id');
    }

    public function scopeFilter($query, array $filters)
    {
        if (isset($filters['name'])) {
            return  $query->whereRaw('LOWER(name) Like ?', ['%' . strtolower($filters['name']) . '%']);
        } else
            return Skill::all();
    }
}
