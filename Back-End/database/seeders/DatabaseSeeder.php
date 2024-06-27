<?php

namespace Database\Seeders;

use App\Models\Auth\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;


class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // User::factory(10)->create();

        $user=User::create([
            'first_name' => 'Admin',
            'last_name' => 'Freelancer',
            'type' => 'Admin',
            'birthdate' => now(),
            'is_active' => true,
            'email' => 'admin@example.com',
            'password' => Hash::make('admin'),            
        ]);

        $this->call(CategorySeeder::class);
        $this->call(SkillSeeder::class);
    }
}
