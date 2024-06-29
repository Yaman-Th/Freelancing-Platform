<?php

namespace Database\Seeders;

use App\Models\Skill;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class SkillSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        {
            $skills = [
                'Arabic',
                'Laravel',
                'Voice Over',
                'Graphic Design',
                'AI Service',
                'Emerging Technologies',
                'PHP',
                'JavaScript',
                'Python',
                'Java',
                'C++',
                'C#',
                'Ruby',
                'Swift',
                'Kotlin',
                'HTML',
                'CSS',
                'SQL',
                'NoSQL',
                'React',
                'Vue.js',
                'Angular',
                'Django',
                'Flask',
                'Spring',
                'Machine Learning',
                'Data Analysis',
                'Data Science',
                'Cyber Security',
                'Blockchain',
                'DevOps',
                'Cloud Computing',
                'AWS',
                'Azure',
                'Google Cloud',
                'Docker',
                'Kubernetes',
                'Microservices',
                'Restful API',
                'GraphQL',
                'Mobile Development',
                'iOS Development',
                'Android Development',
                'Game Development',
                'Unity',
                'Unreal Engine',
                'Augmented Reality',
                'Virtual Reality',
                'UI/UX Design',
                'Project Management',
                'Agile Methodology',
                'Scrum',
                'Content Writing',
                'Copywriting',
                'SEO',
                'Digital Marketing',
                'Social Media Management',
                'Email Marketing',
                'Affiliate Marketing',
                'Sales',
                'Customer Service',
                'Technical Support',
                'IT Support',
                'Network Administration',
                'System Administration',
                'Database Administration',
                'Data Entry',
                'Transcription',
                'Translation',
                'Video Editing',
                'Audio Editing',
                'Photography',
                'Videography',
                '3D Modeling',
                '3D Animation',
                '2D Animation',
                'Illustration',
                'Web Design',
                'Web Development',
                'E-commerce',
                'Shopify',
                'WooCommerce',
                'Magento',
                'BigCommerce',
                'Prestashop',
                'Data Mining',
                'Business Analysis',
                'Market Research',
                'Financial Analysis',
                'Accounting',
                'Bookkeeping',
                'Human Resources',
                'Legal Consulting',
                'Business Consulting',
                'Startup Consulting',
                'Career Coaching',
                'Life Coaching',
                'Fitness Coaching',
                'Nutrition Coaching',
                'Music Production',
                'Sound Design',
                'Voice Acting',
                'Event Planning',
                'Travel Planning',
                'Interior Design',
                'Architecture',
            'cription', 'Voice Over', 'Music Production', 'Sound Design', 'Audio Editing'
            ];
    
            foreach ($skills as $skill) {
                DB::table('skills')->insert([
                    'name' => $skill,
                    // 'created_at' => now(),
                    // 'updated_at' => now(),
                ]);
            }
        }
    }
}
