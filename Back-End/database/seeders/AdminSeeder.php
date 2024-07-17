<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Auth\User;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use Illuminate\Support\Facades\Hash;

class AdminSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $admin = User::create([
            'name'=>'Admin' ,
            'first_name' => 'Admin',
            'last_name' => 'Admin',
            'type' => 'Admin',
            'birthdate' => now(),
            'is_active' => true,
            'email_verified_at'=>now(),
            'email' => 'admin@example.com',
            'password' => Hash::make('adminpassword'),
        ]);
        $admin->assignRole(['admin', '']);

        $permissions = Role::findByName('admin', 'web')->permissions()->pluck('name')->toArray();

        $admin->givePermissionTo($permissions);
    }
}
