<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AppointmentRequestController;
use App\Http\Controllers\AuthController;


Route::prefix('v1')->group(function () {
    // Authentication routes
    Route::post('/auth/register', [AuthController::class, 'register']);
    Route::post('/auth/login', [AuthController::class, 'login']);

    // Protected routes
    Route::middleware('auth:sanctum')->group(function () {
        // Auth routes
        Route::post('/auth/logout', [AuthController::class, 'logout']);
        Route::get('/auth/me', [AuthController::class, 'me']);
        Route::post('/auth/refresh', [AuthController::class, 'refreshToken']);

        // Appointment routes
        Route::apiResource('appointments', AppointmentRequestController::class, [
            'parameters' => ['appointments' => 'appointment_request']
        ]);
        
        // Additional appointment routes
        Route::get('/doctors', [AppointmentRequestController::class, 'doctors']);
        Route::get('/appointments/statistics', [AppointmentRequestController::class, 'statistics']);
        
        // Cancel appointment (alternative to delete)
        Route::patch('/appointments/{appointment_request}/cancel', [AppointmentRequestController::class, 'destroy']);
    });
});
