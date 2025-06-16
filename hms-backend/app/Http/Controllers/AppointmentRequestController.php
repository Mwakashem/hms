<?php

namespace App\Http\Controllers;

use App\Events\AppointmentStatusUpdated;
use App\Http\Requests\StoreAppointmentRequestRequest;
use App\Http\Requests\UpdateAppointmentRequestRequest;
use App\Models\AppointmentRequest;
use App\Models\User;
use App\Notifications\AppointmentStatusChanged;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;

class AppointmentRequestController extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;

    public function __construct()
    {
        $this->middleware('auth:sanctum');
                $this->authorizeResource(AppointmentRequest::class, 'appointment_request');
    }

    public function index(Request $request): JsonResponse
    {
        $user = $request->user();
        $perPage = $request->get('per_page', 15);
        $status = $request->get('status');
        
        $query = $user->isPatient() 
            ? $user->sentAppointments()
            : $user->receivedAppointments();

        if ($status) {
            $query->where('status', $status);
        }

        $appointments = $query
            ->with($this->getRelationships($user))
            ->recent()
            ->paginate($perPage);

        return response()->json([
            'appointments' => $appointments,
            'meta' => $this->getMetaData($user),
        ]);
    }

    public function store(StoreAppointmentRequestRequest $request): JsonResponse
    {
        $appointment = AppointmentRequest::create([
            'patient_id' => $request->user()->id,
            'doctor_id' => $request->doctor_id,
            'preferred_date' => $request->preferred_date,
            'reason' => $request->reason,
            'patient_notes' => $request->patient_notes,
        ]);

        $appointment->load(['patient:id,name,email', 'doctor:id,name,email,specialization']);

        return response()->json([
            'message' => 'Appointment request submitted successfully.',
            'appointment' => $appointment
        ], 201);
    }

    public function show(AppointmentRequest $appointmentRequest): JsonResponse
    {
        $appointmentRequest->load(['patient:id,name,email', 'doctor:id,name,email,specialization']);
        
        return response()->json([
            'appointment' => $appointmentRequest
        ]);
    }

    public function update(UpdateAppointmentRequestRequest $request, AppointmentRequest $appointmentRequest): JsonResponse
    {
        if (!$appointmentRequest->canBeModified()) {
            return response()->json([
                'message' => 'This appointment request cannot be modified.'
            ], 422);
        }

        $appointmentRequest->update([
            'status' => $request->status,
            'doctor_remarks' => $request->doctor_remarks,
        ]);

        $appointmentRequest->markAsResponded();

        // Send notification to patient
        $appointmentRequest->patient->notify(new AppointmentStatusChanged($appointmentRequest));

        // Broadcast real-time event
        broadcast(new AppointmentStatusUpdated($appointmentRequest));

        $appointmentRequest->load(['patient:id,name,email', 'doctor:id,name,email,specialization']);

        return response()->json([
            'message' => 'Appointment request updated successfully.',
            'appointment' => $appointmentRequest
        ]);
    }

    public function destroy(AppointmentRequest $appointmentRequest): JsonResponse
    {
        if (!$appointmentRequest->canBeCancelledByPatient()) {
            return response()->json([
                'message' => 'This appointment request cannot be cancelled.'
            ], 422);
        }

        $appointmentRequest->update(['status' => 'cancelled']);

        return response()->json([
            'message' => 'Appointment request cancelled successfully.'
        ]);
    }

    public function doctors(): JsonResponse
    {
        $doctors = User::doctors()
            ->active()
            ->select('id', 'name', 'email', 'specialization', 'bio')
            ->orderBy('name')
            ->get();

        return response()->json([
            'doctors' => $doctors
        ]);
    }

    public function statistics(Request $request): JsonResponse
    {
        $user = $request->user();
        
        $query = $user->isPatient() 
            ? $user->sentAppointments()
            : $user->receivedAppointments();

        $stats = [
            'total' => $query->count(),
            'pending' => $query->pending()->count(),
            'approved' => $query->approved()->count(),
            'rejected' => $query->rejected()->count(),
        ];

        if ($user->isDoctor()) {
            $stats['response_rate'] = $this->calculateResponseRate($user);
            $stats['avg_response_time'] = $this->calculateAverageResponseTime($user);
        }

        return response()->json([
            'statistics' => $stats
        ]);
    }

    private function getRelationships(User $user): array
    {
        return $user->isPatient() 
            ? ['doctor:id,name,email,specialization']
            : ['patient:id,name,email'];
    }

    private function getMetaData(User $user): array
    {
        $query = $user->isPatient() 
            ? $user->sentAppointments()
            : $user->receivedAppointments();

        return [
            'total_count' => $query->count(),
            'pending_count' => $query->pending()->count(),
            'approved_count' => $query->approved()->count(),
            'rejected_count' => $query->rejected()->count(),
        ];
    }

    private function calculateResponseRate(User $doctor): float
    {
        $total = $doctor->receivedAppointments()->count();
        $responded = $doctor->receivedAppointments()->whereNotNull('responded_at')->count();
        
        return $total > 0 ? round(($responded / $total) * 100, 2) : 0;
    }

    private function calculateAverageResponseTime(User $doctor): ?float
    {
        $appointments = $doctor->receivedAppointments()
            ->whereNotNull('responded_at')
            ->get(['created_at', 'responded_at']);

        if ($appointments->isEmpty()) {
            return null;
        }

        $totalHours = $appointments->sum(function ($appointment) {
            return $appointment->created_at->diffInHours($appointment->responded_at);
        });

        return round($totalHours / $appointments->count(), 2);
    }
}