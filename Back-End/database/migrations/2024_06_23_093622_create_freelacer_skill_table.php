<?php

use App\Models\Auth\Freelancer;
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
        Schema::create('freelacer_skill', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->foreignIdFor(Freelancer::class)->onDelete('cascade');
            $table->foreignIdFor(Skill::class)->onDelete('cascade');

        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('freelacer_skill');
    }
};
