<?php

namespace App\Providers;

use App\Events\AppointmentStatusUpdated;
use App\Listeners\SendAppointmentNotification;
use Illuminate\Foundation\Support\Providers\EventServiceProvider as ServiceProvider;

class EventServiceProvider extends ServiceProvider
{
    protected $listen = [
        AppointmentStatusUpdated::class => [
            // SendAppointmentNotification::class,
        ],
    ];

    public function boot(): void
    {
        //
    }

    public function shouldDiscoverEvents(): bool
    {
        return false;
    }
}
