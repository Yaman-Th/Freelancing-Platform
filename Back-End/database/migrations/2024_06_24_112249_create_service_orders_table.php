<?php

use App\Models\Auth\Client;
use App\Models\Service;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('service_orders', function (Blueprint $table) {
            $table->id();
            $table->foreignId(Service::class)->constrained()->onDelete('cascade');
            $table->foreignId(Client::class)->constrained()->onDelete('cascade');
            $table->date("order_date");
            $table->date("delivery_date");
            $table->string("status");
            $table->bigInteger("total_amount");
            $table->timestamps();
        });
    }


    /**
     * 
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('service_orders');
    }
};

