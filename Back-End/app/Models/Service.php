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
    public function service_order(){
      return $this->hasMany(ServiceOrder::class);
    }
}
