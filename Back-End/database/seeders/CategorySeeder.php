<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Category;

class CategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $programming = Category::create(['name' => 'Programming']);
        $design = Category::create(['name' => 'Design']);
        $writing = Category::create(['name' => 'Writing']);
        $marketing = Category::create(['name' => 'Marketing']);
        $business = Category::create(['name' => 'Business']);
        $data = Category::create(['name' => 'Data']);
        $video = Category::create(['name' => 'Video & Animation']);
        $music = Category::create(['name' => 'Music & Audio']);
        $engineering = Category::create(['name' => 'Engineering & Architecture']);
        $aiServices = Category::create(['name' => 'AI Services']);


        // PROGRAMMING
        Category::create(['name' => 'Web Development', 'parent_id' => $programming->id]);
        Category::create(['name' => 'Mobile Development', 'parent_id' => $programming->id]);
        Category::create(['name' => 'Game Development', 'parent_id' => $programming->id]);
        Category::create(['name' => 'Desktop Applications', 'parent_id' => $programming->id]);
        Category::create(['name' => 'Scripts & Utilities', 'parent_id' => $programming->id]);
        Category::create(['name' => 'E-commerce Development', 'parent_id' => $programming->id]);
        Category::create(['name' => 'QA & Testing', 'parent_id' => $programming->id]);
        Category::create(['name' => 'Frontend Development', 'parent_id' => $programming->id]);
        Category::create(['name' => 'Backend Development', 'parent_id' => $programming->id]);
        Category::create(['name' => 'Full Stack Development', 'parent_id' => $programming->id]);
        Category::create(['name' => 'API Development', 'parent_id' => $programming->id]);
        Category::create(['name' => 'DevOps & Cloud', 'parent_id' => $programming->id]);
        Category::create(['name' => 'Blockchain Development', 'parent_id' => $programming->id]);
        Category::create(['name' => 'Cybersecurity', 'parent_id' => $programming->id]);
        Category::create(['name' => 'IoT Development', 'parent_id' => $programming->id]);

        //DESIGN
        Category::create(['name' => 'Graphic Design', 'parent_id' => $design->id]);
        Category::create(['name' => 'Web & Mobile Design', 'parent_id' => $design->id]);
        Category::create(['name' => 'UI/UX Design', 'parent_id' => $design->id]);
        Category::create(['name' => 'Logo Design', 'parent_id' => $design->id]);
        Category::create(['name' => 'Presentation Design', 'parent_id' => $design->id]);
        Category::create(['name' => 'Infographics', 'parent_id' => $design->id]);
        Category::create(['name' => 'Branding', 'parent_id' => $design->id]);
        Category::create(['name' => 'Print Design', 'parent_id' => $design->id]);
        Category::create(['name' => '3D Design', 'parent_id' => $design->id]);
        Category::create(['name' => 'Fashion Design', 'parent_id' => $design->id]);
        Category::create(['name' => 'Product Design', 'parent_id' => $design->id]);
        Category::create(['name' => 'Illustration', 'parent_id' => $design->id]);
        Category::create(['name' => 'Book Design', 'parent_id' => $design->id]);
       
        //WRITING
        Category::create(['name' => 'Content Writing', 'parent_id' => $writing->id]);
        Category::create(['name' => 'Copywriting', 'parent_id' => $writing->id]);
        Category::create(['name' => 'Technical Writing', 'parent_id' => $writing->id]);
        Category::create(['name' => 'Ghostwriting', 'parent_id' => $writing->id]);
        Category::create(['name' => 'Creative Writing', 'parent_id' => $writing->id]);
        Category::create(['name' => 'Editing & Proofreading', 'parent_id' => $writing->id]);
        Category::create(['name' => 'Article & Blog Writing', 'parent_id' => $writing->id]);
        Category::create(['name' => 'Grant Writing', 'parent_id' => $writing->id]);
        Category::create(['name' => 'Speech Writing', 'parent_id' => $writing->id]);
        Category::create(['name' => 'Resume Writing', 'parent_id' => $writing->id]);
        Category::create(['name' => 'White Papers', 'parent_id' => $writing->id]);
        Category::create(['name' => 'Press Releases', 'parent_id' => $writing->id]);
        //MARKETING
        Category::create(['name' => 'Social Media Marketing', 'parent_id' => $marketing->id]);
        Category::create(['name' => 'SEO', 'parent_id' => $marketing->id]);
        Category::create(['name' => 'Content Marketing', 'parent_id' => $marketing->id]);
        Category::create(['name' => 'Email Marketing', 'parent_id' => $marketing->id]);
        Category::create(['name' => 'Marketing Strategy', 'parent_id' => $marketing->id]);
        Category::create(['name' => 'Public Relations', 'parent_id' => $marketing->id]);
        Category::create(['name' => 'Market Research', 'parent_id' => $marketing->id]);
        Category::create(['name' => 'Telemarketing', 'parent_id' => $marketing->id]);
        Category::create(['name' => 'Video Marketing', 'parent_id' => $marketing->id]);
        Category::create(['name' => 'Affiliate Marketing', 'parent_id' => $marketing->id]);
        Category::create(['name' => 'E-commerce Marketing', 'parent_id' => $marketing->id]);
        Category::create(['name' => 'Community Management', 'parent_id' => $marketing->id]);
        // Business
        Category::create(['name' => 'Virtual Assistant', 'parent_id' => $business->id]);
        Category::create(['name' => 'Customer Service', 'parent_id' => $business->id]);
        Category::create(['name' => 'Project Management', 'parent_id' => $business->id]);
        Category::create(['name' => 'Business Consulting', 'parent_id' => $business->id]);
        Category::create(['name' => 'HR Consulting', 'parent_id' => $business->id]);
        Category::create(['name' => 'Accounting & Consulting', 'parent_id' => $business->id]);
        Category::create(['name' => 'Legal Consulting', 'parent_id' => $business->id]);
        Category::create(['name' => 'Financial Consulting', 'parent_id' => $business->id]);
        Category::create(['name' => 'Career Counseling', 'parent_id' => $business->id]);
        Category::create(['name' => 'Supply Chain Management', 'parent_id' => $business->id]);
        Category::create(['name' => 'Business Plans', 'parent_id' => $business->id]);
        Category::create(['name' => 'Lead Generation', 'parent_id' => $business->id]);

        //DataScience
        Category::create(['name' => 'Data Entry', 'parent_id' => $data->id]);
        Category::create(['name' => 'Data Analytics', 'parent_id' => $data->id]);
        Category::create(['name' => 'Data Science', 'parent_id' => $data->id]);
        Category::create(['name' => 'Data Visualization', 'parent_id' => $data->id]);
        Category::create(['name' => 'Database Management', 'parent_id' => $data->id]);
        Category::create(['name' => 'Data Engineering', 'parent_id' => $data->id]);
        Category::create(['name' => 'Data Mining', 'parent_id' => $data->id]);
        Category::create(['name' => 'Data Cleansing', 'parent_id' => $data->id]);
        Category::create(['name' => 'Big Data', 'parent_id' => $data->id]);
        Category::create(['name' => 'Web Scraping', 'parent_id' => $data->id]);
        Category::create(['name' => 'ETL (Extract, Transform, Load)', 'parent_id' => $data->id]);
        Category::create(['name' => 'Data Warehousing', 'parent_id' => $data->id]);

        //Vider
        Category::create(['name' => 'Video Editing', 'parent_id' => $video->id]);
        Category::create(['name' => 'Animation', 'parent_id' => $video->id]);
        Category::create(['name' => 'Motion Graphics', 'parent_id' => $video->id]);
        Category::create(['name' => 'Whiteboard & Explainer Videos', 'parent_id' => $video->id]);
        Category::create(['name' => '3D Animation', 'parent_id' => $video->id]);
        Category::create(['name' => 'Videography', 'parent_id' => $video->id]);
        Category::create(['name' => 'Spokesperson Videos', 'parent_id' => $video->id]);
        Category::create(['name' => 'Visual Effects', 'parent_id' => $video->id]);
        Category::create(['name' => 'Short Videos', 'parent_id' => $video->id]);
        Category::create(['name' => 'Intros & Outros', 'parent_id' => $video->id]);
        Category::create(['name' => 'Slideshow Videos', 'parent_id' => $video->id]);
        Category::create(['name' => 'Animated GIFs', 'parent_id' => $video->id]);

        //Audio 
        Category::create(['name' => 'Voice Over', 'parent_id' => $music->id]);
        Category::create(['name' => 'Music Production', 'parent_id' => $music->id]);
        Category::create(['name' => 'Audio Engineering', 'parent_id' => $music->id]);
        Category::create(['name' => 'Podcast Editing', 'parent_id' => $music->id]);
        Category::create(['name' => 'Sound Design', 'parent_id' => $music->id]);
        Category::create(['name' => 'Jingles & Intros', 'parent_id' => $music->id]);
        Category::create(['name' => 'Singers & Vocalists', 'parent_id' => $music->id]);
        Category::create(['name' => 'Songwriters', 'parent_id' => $music->id]);
        Category::create(['name' => 'Beat Making', 'parent_id' => $music->id]);
        Category::create(['name' => 'Mixing & Mastering', 'parent_id' => $music->id]);
        Category::create(['name' => 'Music Lessons', 'parent_id' => $music->id]);
        Category::create(['name' => 'Podcast Marketing', 'parent_id' => $music->id]);


        //engineering
        Category::create(['name' => 'Architectural Design', 'parent_id' => $engineering->id]);
        Category::create(['name' => 'Structural Engineering', 'parent_id' => $engineering->id]);
        Category::create(['name' => 'Civil Engineering', 'parent_id' => $engineering->id]);
        Category::create(['name' => 'Electrical Engineering', 'parent_id' => $engineering->id]);
        Category::create(['name' => 'Mechanical Engineering', 'parent_id' => $engineering->id]);
        Category::create(['name' => 'CAD Drafting', 'parent_id' => $engineering->id]);
        Category::create(['name' => 'Interior Design', 'parent_id' => $engineering->id]);
        Category::create(['name' => 'Landscape Design', 'parent_id' => $engineering->id]);
        Category::create(['name' => 'HVAC Engineering', 'parent_id' => $engineering->id]);
        Category::create(['name' => 'Plumbing Engineering', 'parent_id' => $engineering->id]);
        Category::create(['name' => 'Manufacturing Design', 'parent_id' => $engineering->id]);
        Category::create(['name' => '3D Modeling & CAD', 'parent_id' => $engineering->id]);

        //AI Service
        Category::create(['name' => 'Machine Learning', 'parent_id' => $aiServices->id]);
        Category::create(['name' => 'Deep Learning', 'parent_id' => $aiServices->id]);
        Category::create(['name' => 'Natural Language Processing', 'parent_id' => $aiServices->id]);
        Category::create(['name' => 'Computer Vision', 'parent_id' => $aiServices->id]);
        Category::create(['name' => 'AI Chatbots', 'parent_id' => $aiServices->id]);
        Category::create(['name' => 'AI Model Training', 'parent_id' => $aiServices->id]);
        Category::create(['name' => 'AI Consulting', 'parent_id' => $aiServices->id]);
    }
}
