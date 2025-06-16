<?php

namespace App\Policies;

use App\Models\AppointmentRequest;
use App\Models\User;

class AppointmentRequestPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->isDoctor() || $user->isPatient();
    }

    public function view(User $user, AppointmentRequest $appointmentRequest): bool
    {
        return $this->isOwner($user, $appointmentRequest);
    }

    public function create(User $user): bool
    {
        return $user->isPatient();
    }

    public function update(User $user, AppointmentRequest $appointmentRequest): bool
    {
        return $user->isDoctor() && 
               $user->id === $appointmentRequest->doctor_id && 
               $appointmentRequest->canBeModified();
    }

    public function delete(User $user, AppointmentRequest $appointmentRequest): bool
    {
        return $user->isPatient() && 
               $user->id === $appointmentRequest->patient_id && 
               $appointmentRequest->canBeCancelledByPatient();
    }

    public function cancel(User $user, AppointmentRequest $appointmentRequest): bool
    {
        return $this->delete($user, $appointmentRequest);
    }

    private function isOwner(User $user, AppointmentRequest $appointmentRequest): bool
    {
        return $user->id === $appointmentRequest->patient_id || 
               $user->id === $appointmentRequest->doctor_id;
    }
}
