<?php

namespace App\Models;

use App\Models\Service;
use App\Models\Auth\Client;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ServiceOrder extends Model
{
    use HasFactory;
    
    protected $fillable=[
        'service_id',
        'client_id',
        'order_date',
        'delivery_date',
        'status',
        'amount',
        'total'
    ];
    public function client(){
        return $this->belongsTo(Client::class);
    }
    public function service(){
        return $this->belongsTo(Service::class);
    }
    public function Contract(){
        return $this->hasOne(Contract::class);
    }    
}
