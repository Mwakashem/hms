<?php

namespace Database\Seeders;


use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // Create sample doctors
        $doctors = [
            [
                'name' => 'Dr. James Mwangi',
                'email' => 'james.mwangi@hospital.co.ke',
                'specialization' => 'Cardiology',
                'bio' => 'Seasoned cardiologist with over 15 years of experience treating heart conditions across Kenya.',
            ],
            [
                'name' => 'Dr. Achieng Otieno',
                'email' => 'achieng.otieno@hospital.co.ke',
                'specialization' => 'Dermatology',
                'bio' => 'Certified dermatologist focused on skin care solutions tailored to African skin types.',
            ],
            [
                'name' => 'Dr. Peter Kamau',
                'email' => 'peter.kamau@hospital.co.ke',
                'specialization' => 'General Practice',
                'bio' => 'Family doctor providing preventive and chronic care services to urban and rural communities.',
            ],
            [
                'name' => 'Dr. Grace Wambui',
                'email' => 'grace.wambui@hospital.co.ke',
                'specialization' => 'Pediatrics',
                'bio' => 'Pediatric specialist passionate about child health and wellness from infancy to adolescence.',
            ],
            [
                'name' => 'Dr. Kevin Kiptoo',
                'email' => 'kevin.kiptoo@hospital.co.ke',
                'specialization' => 'Orthopedics',
                'bio' => 'Orthopedic expert with experience in trauma surgery and joint rehabilitation in Kenyan hospitals.',
            ],
        ];

        foreach ($doctors as $doctorData) {
            User::create([
                'name' => $doctorData['name'],
                'email' => $doctorData['email'],
                'password' => Hash::make('password123'),
                'role' => 'doctor',
                'specialization' => $doctorData['specialization'],
                'bio' => $doctorData['bio'],
            ]);
        }

        // Create sample patients
        $patients = [
            [
                'name' => 'Mary Njeri',
                'email' => 'mary.njeri@email.co.ke',
            ],
            [
                'name' => 'Daniel Ouma',
                'email' => 'daniel.ouma@email.co.ke',
            ],
            [
                'name' => 'Faith Chebet',
                'email' => 'faith.chebet@email.co.ke',
            ],
            [
                'name' => 'Brian Omondi',
                'email' => 'brian.omondi@email.co.ke',
            ],
            [
                'name' => 'Lucy Wanjiku',
                'email' => 'lucy.wanjiku@email.co.ke',
            ],
        ];

        foreach ($patients as $patientData) {
            User::create([
                'name' => $patientData['name'],
                'email' => $patientData['email'],
                'password' => Hash::make('password123'),
                'role' => 'patient',
            ]);
        }

        // Seed appointment requests
        $this->call(AppointmentRequestSeeder::class);
    }
}

