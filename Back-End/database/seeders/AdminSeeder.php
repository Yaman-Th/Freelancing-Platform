<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Auth\User;
use Illuminate\Support\Facades\Hash;

class AdminSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $admin = User::create([
            'first_name' => 'Admin',
            'last_name' => 'Admin',
            'type' => 'Admin',
            'birthdate' => now(),
            'is_active' => true,
            'email' => 'admin@example.com',
            'password' => Hash::make('adminpassword'),
        ]);
        $admin->assignRole(['admin', '']);
    }
}
