<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Auth\User;
use App\Models\Auth\Freelancer;
use App\Models\Auth\Client;
use Illuminate\Support\Facades\Hash;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $freelancer = User::create([
            'first_name' => 'Yaman',
            'last_name' => 'Tahhan',
            'name' => 'Yaman Tahhan',
            'type' => 'freelancer',
            'birthdate' => '2002-08-02',
            'is_active' => true,
            'email' => 'tahhan152@gmail.com',
            'password' => Hash::make('password'),
        ]);
        Freelancer::create(['user_id' => $freelancer->id]);
        $freelancer->assignRole(['freelancer', '']);

        $freelancerPermissions = Role::findByName('freelancer', 'web')->permissions()->pluck('name')->toArray();

        $freelancer->givePermissionTo($freelancerPermissions);


        $client = User::create([
            'first_name' => 'Besher',
            'last_name' => 'Majzoub',
            'name' => 'Besher Majzuob',
            'type' => 'client',
            'birthdate' => '2002-05-12',
            'is_active' => true,
            'email' => 'besher2002@gmail.com',
            'password' => Hash::make('password'),
        ]);
        Client::create(['user_id' => $client->id]);
        $client->assignRole(['client', '']);

        $clientPermissions = Role::findByName('client', 'web')->permissions()->pluck('name')->toArray();

        $client->givePermissionTo($clientPermissions);
    }
}
