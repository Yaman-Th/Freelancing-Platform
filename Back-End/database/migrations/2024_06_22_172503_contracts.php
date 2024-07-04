<?php

use App\Models\Auth\Client;
use App\Models\Auth\Freelancer;
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
        Schema::create('contracts', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Freelancer::class)->onDelete('cascade');
            $table->foreignIdFor(Client::class)->onDelete('cascade');
            $table->foreignIdFor(ServiceOrder::class)->onDelete('cascade');
            $table->string('type');
            // $table->date('start_date'); we already by create contract we have create at so we don't need that
            $table->date('end_date');
            $table->float('payment_amount');
            $table->string('status');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        //
    }
};
