<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;


use Illuminate\Validation\Rule;

class StoreAppointmentRequestRequest extends FormRequest
{
    public function authorize(): bool
    {
        return auth()->check() && auth()->user()->isPatient();
    }

    public function rules(): array
    {
        return [
            'doctor_id' => [
                'required',
                'integer',
                Rule::exists('users', 'id')->where(function ($query) {
                    $query->where('role', 'doctor')->where('is_active', true);
                }),
            ],
            'preferred_date' => [
                'required',
                'date',
                'after:' . now()->addHour()->toDateTimeString(),
            ],
            'reason' => [
                'required',
                'string',
                'min:10',
                'max:1000',
            ],
            'patient_notes' => [
                'nullable',
                'string',
                'max:500',
            ],
        ];
    }

    public function messages(): array
    {
        return [
            'doctor_id.required' => 'Please select a doctor.',
            'doctor_id.exists' => 'The selected doctor is not available.',
            'preferred_date.required' => 'Please select your preferred appointment date.',
            'preferred_date.after' => 'The preferred date must be at least 1 hour from now.',
            'reason.required' => 'Please provide a reason for your appointment.',
            'reason.min' => 'The reason must be at least 10 characters long.',
            'reason.max' => 'The reason cannot exceed 1000 characters.',
            'patient_notes.max' => 'Additional notes cannot exceed 500 characters.',
        ];
    }

    public function attributes(): array
    {
        return [
            'doctor_id' => 'doctor',
            'preferred_date' => 'preferred appointment date',
            'patient_notes' => 'additional notes',
        ];
    }
}
