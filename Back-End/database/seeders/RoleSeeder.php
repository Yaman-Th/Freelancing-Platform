<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\PermissionRegistrar;

/**
 * Run the database seeds.
 */

class RoleSeeder extends Seeder
{
    public function run()
    {
        app()[PermissionRegistrar::class]->forgetCachedPermissions();
        $permissions = [
            'post.create', 'post.update', 'post.delete',
            'proposal.create', 'proposal.update', 'proposal.accept', 'proposal.reject', 'proposal.delete',
            'service.create', 'service.update', 'service.delete',
            'order.create', 'order.update', 'order.accept', 'order.reject', 'order.delete',
            'category.create', 'category.update', 'category.delete',
            'skill.create', 'skill.update', 'skill.delete',
            'rating.create', 'rating.update', 'rating.delete'
        ];

        // Create permissions
        foreach ($permissions as $permissionName) {
            Permission::create(['name' => $permissionName]);
        }

        // Create roles
        $admin = Role::create(['name' => 'admin']);
        // Assign permissions to roles
        $admin->givePermissionTo($permissions);

        $freelancer = Role::create(['name' => 'freelancer']);
        $freelancer->givePermissionTo([
            'service.create', 'service.update', 'service.delete',
            'proposal.create', 'proposal.update', 'proposal.delete',
        ]);

        $client = Role::create(['name' => 'client']);
        $client->givePermissionTo([
            'post.create', 'post.update', 'post.delete',
            'proposal.accept', 'proposal.reject'
        ]);
    }
}
