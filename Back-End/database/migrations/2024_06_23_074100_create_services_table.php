<?php

use App\Models\Auth\Freelancer;
use App\Models\Auth\User;
use App\Models\Service;
use App\Models\Category;
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
        Schema::create('services', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Freelancer::class)->onDelete('cascade');
            $table->text('title');
            $table->text('description');
            $table->string('image')->nullable();
            $table->unsignedBigInteger('delivery_dayes');
            $table->float('price');
            $table->unsignedBigInteger('category_id');
            $table->foreignIdFor(Category::class)->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('services');
    }
};
