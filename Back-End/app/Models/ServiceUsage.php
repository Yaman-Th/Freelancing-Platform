<?php

namespace App\Models;

use App\Models\Auth\Client;
use App\Models\Service;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ServiceUsage extends Model
{
    use HasFactory;

    protected $fillable=['client_id','service_id'];


    public function client(){
        return $this->belongsTo(Client::class);
    }
    public function service(){
        return $this->belongsTo(Service::class);
    }

}
