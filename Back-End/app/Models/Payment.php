<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Payment extends Model
{
    use HasFactory;

    protected $fillable = [
        'contract_id',
        'amount',
        'payment_method',
        'card_number',
        'expiry_date',
        'cvv',
        'paypal_email'
    ];

    public function contract()
    {
        return $this->belongsTo(Contract::class);
    }
}
