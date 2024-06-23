<?php

use App\Models\Auth\Client;
use App\Models\Contract;
use App\Models\Post;
use App\Models\Skill;
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
        Schema::create('posts', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Client::class)->onDelete('cascade');
            $table->string('title');
            $table->text('description');
            $table->string('type');
            $table->float('budget');
            $table->date('deadline');
            // $table->foreignIdFor(Team::class)->onDelete('cascade');
            // $table->foreignIdFor(Category::class)->onDelete('cascade');
            $table->timestamps();
        });

        Schema::create('post_skill', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Post::class)->onDelete('cascade');
            $table->foreignIdFor(Skill::class)->onDelete('cascade');
            $table->timestamps();
        });

        Schema::create('post_contract', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Post::class)->onDelete('cascade');
            $table->foreignIdFor(Contract::class)->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('posts');
    }
};
