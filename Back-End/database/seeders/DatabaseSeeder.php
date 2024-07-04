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
        app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();
        // User::factory(10)->create();

        $this->call(CategorySeeder::class);
        $this->call(SkillSeeder::class);
        $this->call(RoleSeeder::class);
        $this->call(AdminSeeder::class);
    }
}
