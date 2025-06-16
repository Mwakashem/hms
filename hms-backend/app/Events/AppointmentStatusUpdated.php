<?php

namespace App\Events;

use App\Models\AppointmentRequest;
use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class AppointmentStatusUpdated implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public AppointmentRequest $appointment;

    public function __construct(AppointmentRequest $appointment)
    {
        $this->appointment = $appointment->load(['patient:id,name', 'doctor:id,name']);
    }

    public function broadcastOn(): array
    {
        return [
            new PrivateChannel('user.' . $this->appointment->patient_id),
            new PrivateChannel('user.' . $this->appointment->doctor_id),
        ];
    }

    public function broadcastAs(): string
    {
        return 'appointment.status.updated';
    }

    public function broadcastWith(): array
    {
        return [
            'appointment' => $this->appointment,
            'message' => $this->getStatusMessage(),
        ];
    }

    private function getStatusMessage(): string
    {
        $doctorName = $this->appointment->doctor->name;
        
        return match ($this->appointment->status) {
            'approved' => "Your appointment with Dr. {$doctorName} has been approved.",
            'rejected' => "Your appointment with Dr. {$doctorName} has been rejected.",
            'cancelled' => "Your appointment with Dr. {$doctorName} has been cancelled.",
            default => "Your appointment status has been updated.",
        };
    }
}
