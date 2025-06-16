<?php

namespace App\Providers;

use App\Models\AppointmentRequest;
use App\Policies\AppointmentRequestPolicy;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;

class AuthServiceProvider extends ServiceProvider
{
    protected $policies = [
        AppointmentRequest::class => AppointmentRequestPolicy::class,
    ];

    public function boot(): void
    {
        $this->registerPolicies();
    }
}