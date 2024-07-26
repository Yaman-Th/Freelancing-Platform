<?php

namespace App\Models;

use App\Models\Auth\Client;
use App\Models\Auth\Freelancer;
use App\Models\ServiceOrder;
use App\Models\Payment;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Contract extends Model
{
    use HasFactory;


    protected $fillable=[
        'service_order_id',
        'freelancer_id',
        'client_id',
        'end_date',
        'payment_status',
        'payment_amount',
        'status'
    ];
    public function client(){
        return $this->belongsTo(Client::class);
    }
    public function freelancer(){
        return $this->belongsTo(Freelancer::class);
    }
    
    public function serviceorder(){
        return $this->belongsTo(ServiceOrder::class);
    }
    public function payment(){
        return $this->hasOne(Payment::class);
    }

}
