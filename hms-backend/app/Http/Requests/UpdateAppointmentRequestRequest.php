<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UpdateAppointmentRequestRequest extends FormRequest
{
    public function authorize(): bool
    {
        return auth()->check() && auth()->user()->isDoctor();
    }

    public function rules(): array
    {
        return [
            'status' => [
                'required',
                'string',
                Rule::in(['approved', 'rejected']),
            ],
            'doctor_remarks' => [
                'nullable',
                'string',
                'max:1000',
            ],
        ];
    }

    public function messages(): array
    {
        return [
            'status.required' => 'Please select an action (approve or reject).',
            'status.in' => 'Invalid status. Please select approve or reject.',
            'doctor_remarks.max' => 'Doctor remarks cannot exceed 1000 characters.',
        ];
    }

    public function attributes(): array
    {
        return [
            'doctor_remarks' => 'remarks',
        ];
    }
}