<?php

namespace App\Models;

use App\Models\Auth\Client;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Team extends Model
{
    use HasFactory;

    protected $fillable =[
        "client_id",
        "name",
    ];
    public function client(){
        return $this->hasOne(Client::class);
    }
}
