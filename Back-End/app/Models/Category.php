<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'parent_id'
    ];

    public function parent()
    {
        return $this->belongsTo(Category::class, 'parent_id');
    }

    public function children()
    {
        return $this->hasMany(Category::class, 'parent_id');
    }

    public function scopeFilter($query, array $filters)
    {
        if (isset($filters['name'])) {
            return  $query->whereRaw('LOWER(name) Like ?', ['%'.strtolower($filters['name']).'%']);
        } else
            return Category::all();
    }
}
