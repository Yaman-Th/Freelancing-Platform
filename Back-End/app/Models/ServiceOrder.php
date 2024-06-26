<?php

namespace App\Models;

use App\Models\Service;
use App\Models\Auth\Client;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ServiceOrder extends Model
{
    use HasFactory;
    
    protected $fiilable=[
        'service_id',
        'client_id',
        'oreder_date',
        'delivery_date',
        'status',
        'total_amount'
    ];
    public function client(){
        return $this->belongsTo(Client::class);
    }
    public function service(){
        return $this->belongsTo(Service::class);
    }
    
}
