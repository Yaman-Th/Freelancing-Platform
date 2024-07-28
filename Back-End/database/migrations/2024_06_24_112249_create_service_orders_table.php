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
            $table->text('details');
            $table->bigInteger("quantity");
            $table->date("delivery_date");
            $table->enum('status', ['pending', 'accepted', 'rejected', 'active', 'completed'])->default('pending');
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
