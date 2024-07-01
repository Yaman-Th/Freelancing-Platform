<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;

/**
 * Run the database seeds.
 */

class RoleSeeder extends Seeder
{
    public function run()
    {
        // Create roles
        $admin = Role::create(['name' => 'admin']);
        $freelancer = Role::create(['name' => 'freelancer']);
        $client = Role::create(['name' => 'client']);

        // Create permissions
        Permission::create(['name' => 'accept proposal']);
        Permission::create(['name' => 'reject proposal']);
        Permission::create(['name' => 'accept order']);
        Permission::create(['name' => 'reject order']);

        // Assign permissions to roles
        $admin->givePermissionTo(['accept proposal', 'reject proposal', 'accept order', 'reject order']);
        $client->givePermissionTo(['accept proposal', 'reject proposal']);
        $freelancer->givePermissionTo(['accept order', 'reject order']);
    }
}
