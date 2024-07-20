<?php

namespace App\Policies;

use App\Models\Service;
use App\Models\Auth\User;
use Illuminate\Auth\Access\Response;

class ServicePolicy
{

    /**
     * Determine whether the user can create models.
     */
    public function create(User $user): bool
    {
        if ($user->hasPermissionTo('service.create'))
            return true;
        else return false;
    }

    /**
     * Determine whether the user can update the model.
     */
    public function update(User $user, Service $service): bool
    {
        $freelancer = $user->freelancer()->first();
        if ($user->hasPermissionTo('service.update') && $freelancer->id == $service->freelancer_id)
            return true;
        else return false;
    }

    /**
     * Determine whether the user can delete the model.
     */
    public function delete(User $user, Service $service): bool
    {
        $freelancer = $user->freelancer()->first();
        if ($user->hasPermissionTo('service.delete') && $freelancer->id == $service->freelancer_id)
            return true;
        else return false;
    }
}
