<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Carbon\Carbon;

class AppointmentRequest extends Model
{
    use HasFactory;

    protected $fillable = [
        'patient_id',
        'doctor_id',
        'preferred_date',
        'reason',
        'status',
        'doctor_remarks',
        'patient_notes',
        'responded_at',
    ];

    protected $casts = [
        'preferred_date' => 'datetime',
        'responded_at' => 'datetime',
    ];

    // Relationships
    public function patient(): BelongsTo
    {
        return $this->belongsTo(User::class, 'patient_id');
    }

    public function doctor(): BelongsTo
    {
        return $this->belongsTo(User::class, 'doctor_id');
    }

    // Scopes
    public function scopePending($query)
    {
        return $query->where('status', 'pending');
    }

    public function scopeApproved($query)
    {
        return $query->where('status', 'approved');
    }

    public function scopeRejected($query)
    {
        return $query->where('status', 'rejected');
    }

    public function scopeRecent($query)
    {
        return $query->orderBy('created_at', 'desc');
    }

    // Status check methods
    public function isPending(): bool
    {
        return $this->status === 'pending';
    }

    public function isApproved(): bool
    {
        return $this->status === 'approved';
    }

    public function isRejected(): bool
    {
        return $this->status === 'rejected';
    }

    public function isCancelled(): bool
    {
        return $this->status === 'cancelled';
    }

    public function canBeModified(): bool
    {
        return $this->isPending();
    }

    public function canBeCancelledByPatient(): bool
    {
        return $this->isPending() || ($this->isApproved() && $this->preferred_date->isFuture());
    }

    // Helper methods
    public function getStatusColorAttribute(): string
    {
        return match ($this->status) {
            'pending' => 'warning',
            'approved' => 'success',
            'rejected' => 'danger',
            'cancelled' => 'secondary',
            default => 'primary',
        };
    }

    public function getFormattedPreferredDateAttribute(): string
    {
        return $this->preferred_date->format('M d, Y \a\t g:i A');
    }

    public function markAsResponded(): void
    {
        $this->update(['responded_at' => now()]);
    }
}
