<?php

namespace App\Models;

use App\Models\Auth\Freelancer;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Service extends Model
{
  use HasFactory;

  protected $fillable = [
    "freelancer_id",
    "title",
    "description",
    "image",
    "delivery_dayes",
    "price",
    "category_id"
  ];
  public function freelancer()
  {
    return  $this->belongsTo(Freelancer::class);
  }
  public function skill()
  {
    return $this->hasMany(Skill::class);
  }
  public function category()
  {
    return $this->belongsTo(category::class);
  }
  public function service_order()
  {
    return $this->hasMany(ServiceOrder::class);
  }
  public function scopeFilter($query, array $filters)
  {
    if (isset($filters['title'])) {
      $query->where('title', 'like', '%' . $filters['title'] . '%');
    }
    if (isset($filters['description'])) {
      $query->where('description','like', '%' . $filters['description'] . '%');
    }
    if (isset($filters['price'])) {
      $query->where('price', '<=', $filters['price']);
    }
    if (isset($filters['delivery_dayes'])) {
      $query->where('delivery_dayes', '<=', $filters['delivery_dayes']);
    }
    if (isset($filters['category'])) {
      $category = Category::whereRaw('LOWER(name) = ?', [strtolower($filters['category'])])->first();
      if ($category) {
        $query->where('category_id', $category->id);
      }
      if (isset($filters['ratings'])) {
        $query->where('ratings', '>=', $filters['ratings']);
      }
    }

    return $query;
  }
}
