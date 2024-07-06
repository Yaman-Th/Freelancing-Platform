<?php

use App\Models\Auth\Client;
use App\Models\Service;
use App\Models\ServiceOrder;
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
            $table->foreignIdFor(Service::class)->constrained()->onDelete('cascade');
            $table->foreignIdFor(Client::class)->constrained()->onDelete('cascade');
            $table->date("order_date");
            $table->date("delivery_date");
            $table->string("status");
            // $table->bigInteger("amount");
            $table->float("total_amount");
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
