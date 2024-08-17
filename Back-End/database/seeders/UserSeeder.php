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
        $usersData = [
            [
                'first_name' => 'Yaman',
                'last_name' => 'Tahhan',
                'name' => 'Yaman Tahhan',
                'type' => 'freelancer',
                'birthdate' => '2002-08-02',
                'email' => 'tahhan152@gmail.com',
                'role' => 'freelancer',
            ],
            [
                'first_name' => 'Besher',
                'last_name' => 'Majzoub',
                'name' => 'Besher Majzoub',
                'type' => 'client',
                'birthdate' => '2002-05-12',
                'email' => 'besher2002@gmail.com',
                'role' => 'client',
            ],
            // هنا ستجد السجلات الـ 20 الإضافية
            [
                'first_name' => 'Sara',
                'last_name' => 'Hassan',
                'name' => 'Sara Hassan',
                'type' => 'freelancer',
                'birthdate' => '1995-03-10',
                'email' => 'sara.hassan@example.com',
                'role' => 'freelancer',
            ],
            [
                'first_name' => 'Ali',
                'last_name' => 'Khaled',
                'name' => 'Ali Khaled',
                'type' => 'client',
                'birthdate' => '1988-11-22',
                'email' => 'ali.khaled@example.com',
                'role' => 'client',
            ],
            [
                'first_name' => 'Lina',
                'last_name' => 'Omar',
                'name' => 'Lina Omar',
                'type' => 'freelancer',
                'birthdate' => '1990-07-17',
                'email' => 'lina.omar@example.com',
                'role' => 'freelancer',
            ],
            [
                'first_name' => 'Fadi',
                'last_name' => 'Nasser',
                'name' => 'Fadi Nasser',
                'type' => 'client',
                'birthdate' => '1992-01-30',
                'email' => 'fadi.nasser@example.com',
                'role' => 'client',
            ],
            [
                'first_name' => 'Mona',
                'last_name' => 'Saleh',
                'name' => 'Mona Saleh',
                'type' => 'freelancer',
                'birthdate' => '1994-05-05',
                'email' => 'mona.saleh@example.com',
                'role' => 'freelancer',
            ],
            [
                'first_name' => 'Omar',
                'last_name' => 'Adel',
                'name' => 'Omar Adel',
                'type' => 'client',
                'birthdate' => '1987-09-19',
                'email' => 'omar.adel@example.com',
                'role' => 'client',
            ],
            [
                'first_name' => 'Nadia',
                'last_name' => 'Fouad',
                'name' => 'Nadia Fouad',
                'type' => 'freelancer',
                'birthdate' => '1993-02-28',
                'email' => 'nadia.fouad@example.com',
                'role' => 'freelancer',
            ],
            [
                'first_name' => 'Khaled',
                'last_name' => 'Hussein',
                'name' => 'Khaled Hussein',
                'type' => 'client',
                'birthdate' => '1989-12-14',
                'email' => 'khaled.hussein@example.com',
                'role' => 'client',
            ],
            [
                'first_name' => 'Fatima',
                'last_name' => 'Ali',
                'name' => 'Fatima Ali',
                'type' => 'freelancer',
                'birthdate' => '1996-06-08',
                'email' => 'fatima.ali@example.com',
                'role' => 'freelancer',
            ],
            [
                'first_name' => 'Hassan',
                'last_name' => 'Mohamed',
                'name' => 'Hassan Mohamed',
                'type' => 'client',
                'birthdate' => '1991-04-22',
                'email' => 'hassan.mohamed@example.com',
                'role' => 'client',
            ],
            [
                'first_name' => 'Amira',
                'last_name' => 'Youssef',
                'name' => 'Amira Youssef',
                'type' => 'freelancer',
                'birthdate' => '1997-08-12',
                'email' => 'amira.youssef@example.com',
                'role' => 'freelancer',
            ],
            [
                'first_name' => 'Tarek',
                'last_name' => 'Ahmed',
                'name' => 'Tarek Ahmed',
                'type' => 'client',
                'birthdate' => '1985-07-05',
                'email' => 'tarek.ahmed@example.com',
                'role' => 'client',
            ],
            [
                'first_name' => 'Dina',
                'last_name' => 'Samir',
                'name' => 'Dina Samir',
                'type' => 'freelancer',
                'birthdate' => '1998-11-23',
                'email' => 'dina.samir@example.com',
                'role' => 'freelancer',
            ],
            [
                'first_name' => 'Rami',
                'last_name' => 'Faris',
                'name' => 'Rami Faris',
                'type' => 'client',
                'birthdate' => '1986-10-12',
                'email' => 'rami.faris@example.com',
                'role' => 'client',
            ],
            [
                'first_name' => 'Laila',
                'last_name' => 'Hamad',
                'name' => 'Laila Hamad',
                'type' => 'freelancer',
                'birthdate' => '1995-09-09',
                'email' => 'laila.hamad@example.com',
                'role' => 'freelancer',
            ],
            [
                'first_name' => 'Ahmad',
                'last_name' => 'Mansour',
                'name' => 'Ahmad Mansour',
                'type' => 'client',
                'birthdate' => '1990-03-17',
                'email' => 'ahmad.mansour@example.com',
                'role' => 'client',
            ],
            [
                'first_name' => 'Hala',
                'last_name' => 'Abdallah',
                'name' => 'Hala Abdallah',
                'type' => 'freelancer',
                'birthdate' => '1992-02-05',
                'email' => 'hala.abdallah@example.com',
                'role' => 'freelancer',
            ],
            [
                'first_name' => 'Ziad',
                'last_name' => 'Mahmoud',
                'name' => 'Ziad Mahmoud',
                'type' => 'client',
                'birthdate' => '1987-06-21',
                'email' => 'ziad.mahmoud@example.com',
                'role' => 'client',
            ],
        ];

        foreach ($usersData as $userData) {
            $user = User::create([
                'first_name' => $userData['first_name'],
                'last_name' => $userData['last_name'],
                'name' => $userData['name'],
                'type' => $userData['type'],
                'birthdate' => $userData['birthdate'],
                'is_active' => true,
                'email' => $userData['email'],
                'password' => Hash::make('password'),
            ]);

            if ($userData['type'] === 'freelancer') {
                Freelancer::create(['user_id' => $user->id]);
                $user->assignRole(['freelancer', '']);
            } else if ($userData['type'] === 'client') {
                Client::create(['user_id' => $user->id]);
                $user->assignRole(['client', '']);
            }

            $permissions = Role::findByName($userData['role'], 'web')->permissions()->pluck('name')->toArray();
            $user->givePermissionTo($permissions);
        }
    }
}
