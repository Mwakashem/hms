<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Laravel\Sanctum\NewAccessToken;

/**
 * @method NewAccessToken createToken(string $name, array $abilities = ['*'])
 * @property int $id
 * @property string $name
 * @property string $email
 * @property string $password
 * @property string $role
 * @property string|null $specialization
 * @property string|null $bio
 * @property bool $is_active
 * @property \Illuminate\Support\Carbon|null $email_verified_at
 * @property string|null $remember_token
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read string $full_name
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\AppointmentRequest> $sentAppointments
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\AppointmentRequest> $receivedAppointments
 */
class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    protected $fillable = [
        'name',
        'email',
        'password',
        'role',
        'specialization',
        'bio',
        'is_active',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
        'is_active' => 'boolean',
    ];

    // Relationships
    public function sentAppointments(): HasMany
    {
        return $this->hasMany(AppointmentRequest::class, 'patient_id');
    }

    public function receivedAppointments(): HasMany
    {
        return $this->hasMany(AppointmentRequest::class, 'doctor_id');
    }

    // Scopes
    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }

    public function scopeDoctors($query)
    {
        return $query->where('role', 'doctor');
    }

    public function scopePatients($query)
    {
        return $query->where('role', 'patient');
    }

    // Helper methods
    public function isDoctor(): bool
    {
        return $this->role === 'doctor';
    }

    public function isPatient(): bool
    {
        return $this->role === 'patient';
    }

    public function getFullNameAttribute(): string
    {
        return $this->isDoctor() ? "Dr. {$this->name}" : $this->name;
    }
}