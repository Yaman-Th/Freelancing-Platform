<?php

use App\Models\Service;
use App\Models\Auth\Client;
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;
use App\Models\Post;
return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('ratings', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Service::class)->onDelete('cascade');
            $table->foreignId(Client::class)->onDelete('cascade');
            $table->bigInteger('Score');
            $table->text("comment");
            // $table->foreignId(Post::class)->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ratings');
    }
};
