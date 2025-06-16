<?php

namespace App\Notifications;

use App\Models\AppointmentRequest;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class AppointmentStatusChanged extends Notification implements ShouldQueue
{
    use Queueable;

    public function __construct(
        protected AppointmentRequest $appointment
    ) {}

    public function via(object $notifiable): array
    {
        return ['mail', 'database'];
    }

    public function toMail(object $notifiable): MailMessage
    {
        $status = ucfirst($this->appointment->status);
        $doctorName = $this->appointment->doctor->full_name;

        $message = (new MailMessage)
            ->subject("Appointment Request {$status}")
            ->greeting("Hello {$notifiable->name},")
            ->line("Your appointment request with {$doctorName} has been {$this->appointment->status}.")
            ->line("**Appointment Details:**")
            ->line("Preferred Date: {$this->appointment->formatted_preferred_date}")
            ->line("Reason: {$this->appointment->reason}");

        if ($this->appointment->doctor_remarks) {
            $message->line("**Doctor's Remarks:** {$this->appointment->doctor_remarks}");
        }

        return $message
            ->action('View Appointment', url("/appointments/{$this->appointment->id}"))
            ->line('Thank you for using our appointment system!');
    }

    public function toArray(object $notifiable): array
    {
        return [
            'appointment_id' => $this->appointment->id,
            'status' => $this->appointment->status,
            'doctor_name' => $this->appointment->doctor->full_name,
            'doctor_remarks' => $this->appointment->doctor_remarks,
            'preferred_date' => $this->appointment->formatted_preferred_date,
            'title' => $this->getNotificationTitle(),
            'message' => $this->getNotificationMessage(),
        ];
    }

    private function getNotificationTitle(): string
    {
        return match ($this->appointment->status) {
            'approved' => 'Appointment Approved',
            'rejected' => 'Appointment Rejected',
            'cancelled' => 'Appointment Cancelled',
            default => 'Appointment Updated',
        };
    }

    private function getNotificationMessage(): string
    {
        $doctorName = $this->appointment->doctor->full_name;
        
        return match ($this->appointment->status) {
            'approved' => "Your appointment with {$doctorName} has been approved.",
            'rejected' => "Your appointment with {$doctorName} has been rejected.",
            'cancelled' => "Your appointment with {$doctorName} has been cancelled.",
            default => "Your appointment status has been updated.",
        };
    }
}
