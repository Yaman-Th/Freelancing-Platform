<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Post;
use App\Models\Auth\Client;

class PostSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // جلب جميع معرفات العملاء من قاعدة البيانات
        $clientIds = Client::pluck('id')->toArray();

        // التأكد من وجود معرفات عملاء قبل إضافة البيانات
        if (empty($clientIds)) {
            $this->command->error('No client IDs found. Please ensure that clients are seeded before running this seeder.');
            return;
        }

        $posts = [
            [
                'category_id' => 2,
                'title' => 'Fullstack Developer',
                'description' => 'We are hiring fullstack developers with 2 years of experience. Salary: $10,000 monthly.',
                'type' => 'job',
                'budget' => 10000,
                'deadline' => '2024-07-01',
                'client_id' => $clientIds[0 % count($clientIds)],
            ],
            [
                'category_id' => 1,
                'title' => 'Frontend Developer',
                'description' => 'Looking for a frontend developer with experience in React.js.',
                'type' => 'job',
                'budget' => 15000,
                'deadline' => '2024-08-15',
                'client_id' => $clientIds[1 % count($clientIds)],
            ],
            [
                'category_id' => 4,
                'title' => 'Digital Marketing Specialist',
                'description' => 'Need a digital marketing specialist for a 3-month contract.',
                'type' => 'job',
                'budget' => 20000,
                'deadline' => '2024-09-01',
                'client_id' => $clientIds[2 % count($clientIds)],
            ],
            [
                'category_id' => 5,
                'title' => 'Business Analyst',
                'description' => 'Hiring a business analyst with 5 years of experience.',
                'type' => 'job',
                'budget' => 30000,
                'deadline' => '2024-10-10',
                'client_id' => $clientIds[3 % count($clientIds)],
            ],
            [
                'category_id' => 6,
                'title' => 'Data Scientist',
                'description' => 'Seeking a data scientist with expertise in machine learning.',
                'type' => 'job',
                'budget' => 40000,
                'deadline' => '2024-11-20',
                'client_id' => $clientIds[4 % count($clientIds)],
            ],
            [
                'category_id' => 7,
                'title' => 'Video Editor',
                'description' => 'Looking for a video editor for our YouTube channel.',
                'type' => 'job',
                'budget' => 12000,
                'deadline' => '2024-12-05',
                'client_id' => $clientIds[5 % count($clientIds)],
            ],
            [
                'category_id' => 8,
                'title' => 'Sound Engineer',
                'description' => 'Need a sound engineer for a short film project.',
                'type' => 'job',
                'budget' => 25000,
                'deadline' => '2024-08-20',
                'client_id' => $clientIds[6 % count($clientIds)],
            ],
            [
                'category_id' => 9,
                'title' => 'Architect',
                'description' => 'Hiring an architect for a residential building project.',
                'type' => 'job',
                'budget' => 60000,
                'deadline' => '2024-09-30',
                'client_id' => $clientIds[7 % count($clientIds)],
            ],
            [
                'category_id' => 10,
                'title' => 'AI Consultant',
                'description' => 'Seeking an AI consultant to optimize our machine learning models.',
                'type' => 'job',
                'budget' => 50000,
                'deadline' => '2024-10-25',
                'client_id' => $clientIds[8 % count($clientIds)],
            ],
            [
                'category_id' => 2,
                'title' => 'Backend Developer',
                'description' => 'Need a backend developer with expertise in Node.js.',
                'type' => 'job',
                'budget' => 22000,
                'deadline' => '2024-11-15',
                'client_id' => $clientIds[9 % count($clientIds)],
            ],
            [
                'category_id' => 4,
                'title' => 'Social Media Manager',
                'description' => 'Looking for a social media manager for a 6-month contract.',
                'type' => 'job',
                'budget' => 18000,
                'deadline' => '2024-12-10',
                'client_id' => $clientIds[0 % count($clientIds)],
            ],
            [
                'category_id' => 1,
                'title' => 'Mobile App Developer',
                'description' => 'Hiring a mobile app developer for iOS and Android projects.',
                'type' => 'job',
                'budget' => 40000,
                'deadline' => '2024-07-30',
                'client_id' => $clientIds[1 % count($clientIds)],
            ],
            [
                'category_id' => 5,
                'title' => 'Project Manager',
                'description' => 'Seeking a project manager with experience in agile methodologies.',
                'type' => 'job',
                'budget' => 35000,
                'deadline' => '2024-08-25',
                'client_id' => $clientIds[2 % count($clientIds)],
            ],
            [
                'category_id' => 6,
                'title' => 'Machine Learning Engineer',
                'description' => 'Looking for a machine learning engineer to develop predictive models.',
                'type' => 'job',
                'budget' => 50000,
                'deadline' => '2024-09-15',
                'client_id' => $clientIds[3 % count($clientIds)],
            ],
            [
                'category_id' => 7,
                'title' => 'Animator',
                'description' => 'Seeking an animator for creating promotional videos.',
                'type' => 'job',
                'budget' => 30000,
                'deadline' => '2024-10-20',
                'client_id' => $clientIds[4 % count($clientIds)],
            ],
            [
                'category_id' => 8,
                'title' => 'Audio Engineer',
                'description' => 'Need an audio engineer for podcast editing.',
                'type' => 'job',
                'budget' => 15000,
                'deadline' => '2024-11-10',
                'client_id' => $clientIds[5 % count($clientIds)],
            ],
            [
                'category_id' => 9,
                'title' => 'Structural Engineer',
                'description' => 'Hiring a structural engineer for a new office building.',
                'type' => 'job',
                'budget' => 55000,
                'deadline' => '2024-12-20',
                'client_id' => $clientIds[6 % count($clientIds)],
            ],
            [
                'category_id' => 10,
                'title' => 'Data Analyst',
                'description' => 'Looking for a data analyst to interpret large datasets.',
                'type' => 'job',
                'budget' => 35000,
                'deadline' => '2024-07-20',
                'client_id' => $clientIds[7 % count($clientIds)],
            ],
            [
                'category_id' => 2,
                'title' => 'DevOps Engineer',
                'description' => 'Seeking a DevOps engineer to manage cloud infrastructure.',
                'type' => 'job',
                'budget' => 40000,
                'deadline' => '2024-08-30',
                'client_id' => $clientIds[8 % count($clientIds)],
            ],
            [
                'category_id' => 4,
                'title' => 'Content Writer',
                'description' => 'Need a content writer for blog posts and articles.',
                'type' => 'job',
                'budget' => 18000,
                'deadline' => '2024-09-05',
                'client_id' => $clientIds[9 % count($clientIds)],
            ],
            [
                'category_id' => 1,
                'title' => 'UX/UI Designer',
                'description' => 'Hiring a UX/UI designer for a website redesign project.',
                'type' => 'job',
                'budget' => 25000,
                'deadline' => '2024-10-01',
                'client_id' => $clientIds[0 % count($clientIds)],
            ],
            [
                'category_id' => 7,
                'title' => 'Graphic Designer',
                'description' => 'Looking for a graphic designer to create branding materials.',
                'type' => 'job',
                'budget' => 20000,
                'deadline' => '2024-11-15',
                'client_id' => $clientIds[1 % count($clientIds)],
            ],
            [
                'category_id' => 8,
                'title' => 'Voice Actor',
                'description' => 'Need a voice actor for a commercial project.',
                'type' => 'job',
                'budget' => 25000,
                'deadline' => '2024-12-01',
                'client_id' => $clientIds[2 % count($clientIds)],
            ],
        ];

        foreach ($posts as $post) {
            Post::create($post);
        }
    }
}
