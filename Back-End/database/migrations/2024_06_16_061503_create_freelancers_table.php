<?php

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
        Schema::create('freelancers', function (Blueprint $table) {
            $table->id()->unique();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->text("personal_overview")->nullable();
            $table->string('personal_image')->nullable();
            $table->double("wallet")->default('0');
            $table->boolean("is_avilable")->default(true);
            $table->timestamps();


        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('freelancers');
    }
};
