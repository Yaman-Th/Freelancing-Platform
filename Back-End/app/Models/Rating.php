<?php

namespace App\Models;

use App\Models\Auth\Client;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Rating extends Model
{
    use HasFactory;

    protected $fiilable=['client_id','service_id','score','comment','project_id'];



    public function client(){
        return $this->belongsTo(Client::class);
    }
    public function service(){
        return $this->belongsTo(Service::class);
    }
    public function post(){
    }
}
