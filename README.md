# 🏥 Health Appointment Request System

A **fullstack application** built with **Laravel 10+** and **Vue 3** for managing health appointment requests between patients and doctors.

---

## 🚀 Quick Setup

### ✅ Prerequisites

- PHP 8.1+
- Composer
- Node.js 16+
- MySQL or PostgreSQL
- Laravel CLI

---

## ⚙️ Installation

### 1. Clone and Setup Laravel Backend


git clone <your-repo-url>
cd hms-backend

# Backend setup
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate --seed
php artisan serve

cd hms-frontend
npm install
npm run dev
## Update db connection
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=health_appointments
DB_USERNAME=root
DB_PASSWORD=


## Testing credential if you load the sql provided
👨‍⚕️ Doctor Account
Email: doctor@example.com

Password: password123

🧑‍⚕️ Patient Account
Email: patient@example.com

Password: password123

```bash