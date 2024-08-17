<?php
namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Service;
use App\Models\Auth\Freelancer;

class ServiceSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // جلب جميع معرفات مقدمي الخدمات من قاعدة البيانات
        $freelancerIds = Freelancer::pluck('id')->toArray();

        // التأكد من وجود معرفات مقدمي الخدمات قبل إضافة البيانات
        if (empty($freelancerIds)) {
            $this->command->error('No freelancer IDs found. Please ensure that freelancers are seeded before running this seeder.');
            return;
        }

        $services = [
            [
                'title' => 'Web Development',
                'description' => 'Building responsive and high-performance websites.',
                'delivery_dayes' => 7,
                'price' => 300,
                'category_id' => 1, // Programming
                'freelancer_id' => $freelancerIds[0 % count($freelancerIds)],
            ],
            [
                'title' => 'Logo Design',
                'description' => 'Custom logo design that reflects your brand identity.',
                'delivery_dayes' => 5,
                'price' => 150,
                'category_id' => 2, // Design
                'freelancer_id' => $freelancerIds[1 % count($freelancerIds)],
            ],
            [
                'title' => 'SEO Optimization',
                'description' => 'Improving your website’s search engine ranking.',
                'delivery_dayes' => 10,
                'price' => 200,
                'category_id' => 4, // Marketing
                'freelancer_id' => $freelancerIds[2 % count($freelancerIds)],
            ],
            [
                'title' => 'Business Plan Writing',
                'description' => 'Creating comprehensive and effective business plans.',
                'delivery_dayes' => 14,
                'price' => 400,
                'category_id' => 5, // Business
                'freelancer_id' => $freelancerIds[3 % count($freelancerIds)],
            ],
            [
                'title' => 'Data Analysis',
                'description' => 'Analyzing and interpreting complex data sets.',
                'delivery_dayes' => 8,
                'price' => 250,
                'category_id' => 6, // Data
                'freelancer_id' => $freelancerIds[4 % count($freelancerIds)],
            ],
            [
                'title' => 'Video Editing',
                'description' => 'Editing videos to enhance quality and engagement.',
                'delivery_dayes' => 7,
                'price' => 180,
                'category_id' => 7, // Video & Animation
                'freelancer_id' => $freelancerIds[5 % count($freelancerIds)],
            ],
            [
                'title' => 'Audio Mixing',
                'description' => 'Mixing and mastering audio tracks for clarity and balance.',
                'delivery_dayes' => 6,
                'price' => 120,
                'category_id' => 8, // Music & Audio
                'freelancer_id' => $freelancerIds[6 % count($freelancerIds)],
            ],
            [
                'title' => 'Architectural Design',
                'description' => 'Designing innovative and functional architectural plans.',
                'delivery_dayes' => 20,
                'price' => 600,
                'category_id' => 9, // Engineering & Architecture
                'freelancer_id' => $freelancerIds[7 % count($freelancerIds)],
            ],
            [
                'title' => 'AI Model Training',
                'description' => 'Training AI models to improve accuracy and performance.',
                'delivery_dayes' => 15,
                'price' => 500,
                'category_id' => 10, // AI Services
                'freelancer_id' => $freelancerIds[8 % count($freelancerIds)],
            ],
            [
                'title' => 'UI/UX Design',
                'description' => 'Creating user-friendly interfaces and experiences.',
                'delivery_dayes' => 12,
                'price' => 350,
                'category_id' => 2, // Design
                'freelancer_id' => $freelancerIds[9 % count($freelancerIds)],
            ],
            [
                'title' => 'Social Media Management',
                'description' => 'Managing social media accounts to increase engagement.',
                'delivery_dayes' => 30,
                'price' => 400,
                'category_id' => 4, // Marketing
                'freelancer_id' => $freelancerIds[0 % count($freelancerIds)],
            ],
            [
                'title' => 'Content Writing',
                'description' => 'Crafting engaging and informative content for various platforms.',
                'delivery_dayes' => 7,
                'price' => 160,
                'category_id' => 2, // Design
                'freelancer_id' => $freelancerIds[1 % count($freelancerIds)],
            ],
            [
                'title' => 'Market Research',
                'description' => 'Conducting research to understand market trends and consumer needs.',
                'delivery_dayes' => 10,
                'price' => 220,
                'category_id' => 4, // Marketing
                'freelancer_id' => $freelancerIds[2 % count($freelancerIds)],
            ],
            [
                'title' => 'Financial Analysis',
                'description' => 'Analyzing financial data to support business decisions.',
                'delivery_dayes' => 10,
                'price' => 270,
                'category_id' => 5, // Business
                'freelancer_id' => $freelancerIds[3 % count($freelancerIds)],
            ],
            [
                'title' => 'Machine Learning Algorithms',
                'description' => 'Developing and implementing machine learning algorithms.',
                'delivery_dayes' => 20,
                'price' => 550,
                'category_id' => 6, // Data
                'freelancer_id' => $freelancerIds[4 % count($freelancerIds)],
            ],
            [
                'title' => '3D Animation',
                'description' => 'Creating high-quality 3D animations for various purposes.',
                'delivery_dayes' => 25,
                'price' => 700,
                'category_id' => 7, // Video & Animation
                'freelancer_id' => $freelancerIds[5 % count($freelancerIds)],
            ],
            [
                'title' => 'Music Production',
                'description' => 'Producing music tracks with professional quality.',
                'delivery_dayes' => 15,
                'price' => 300,
                'category_id' => 8, // Music & Audio
                'freelancer_id' => $freelancerIds[6 % count($freelancerIds)],
            ],
            [
                'title' => 'Structural Design',
                'description' => 'Designing structures with a focus on safety and functionality.',
                'delivery_dayes' => 20,
                'price' => 600,
                'category_id' => 9, // Engineering & Architecture
                'freelancer_id' => $freelancerIds[7 % count($freelancerIds)],
            ],
            [
                'title' => 'AI Consultation',
                'description' => 'Consulting on AI technologies and implementation strategies.',
                'delivery_dayes' => 15,
                'price' => 450,
                'category_id' => 10, // AI Services
                'freelancer_id' => $freelancerIds[8 % count($freelancerIds)],
            ],
            [
                'title' => 'Website Redesign',
                'description' => 'Redesigning existing websites for a fresh and modern look.',
                'delivery_dayes' => 14,
                'price' => 350,
                'category_id' => 1, // Programming
                'freelancer_id' => $freelancerIds[9 % count($freelancerIds)],
            ],
            [
                'title' => 'Brand Identity Design',
                'description' => 'Developing a cohesive brand identity including logos and color schemes.',
                'delivery_dayes' => 20,
                'price' => 400,
                'category_id' => 2, // Design
                'freelancer_id' => $freelancerIds[0 % count($freelancerIds)],
            ],
            [
                'title' => 'Email Marketing Campaign',
                'description' => 'Creating and managing email marketing campaigns.',
                'delivery_dayes' => 10,
                'price' => 180,
                'category_id' => 4, // Marketing
                'freelancer_id' => $freelancerIds[1 % count($freelancerIds)],
            ],
        ];

        foreach ($services as $service) {


            Service::create($service);
        }
    }
}
