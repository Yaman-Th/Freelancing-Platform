<?php

use App\Models\Team;
use App\Models\Auth\Freelancer;
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('team_members', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Team::class)->onDelete('cascade');
            $table->foreignIdFor(Freelancer::class)->onDelete('cascade');
            $table->timestamps(); // we can take  the join date from here
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('team_members');
    }
};
