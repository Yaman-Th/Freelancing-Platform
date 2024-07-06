<?php

namespace App\Policies;

use App\Models\ServiceOrder;
use App\Models\Auth\User;
use Illuminate\Auth\Access\Response;

class ServiceOrderPolicy
{

    /**
     * Determine whether the user can create models.
     */
    public function create(User $user): bool
    {
        return $user->hasPermissionTo('order.create');
    }

    /**
     * Determine whether the user can update the model.
     */
    public function update(User $user, ServiceOrder $serviceOrder): bool
    {
        $client = $user->client()->first();
        if ($user->hasPermissionTo('order.update') && $client->id == $serviceOrder->client_id)
            return true;
        else return false;
    }

    public function updateStatus(User $user, ServiceOrder $serviceOrder): bool
    {
        $freelancer = $user->freelancer()->first();
        $service = $serviceOrder->service()->first();

        return $service->id == $serviceOrder->service_id &&
            $freelancer->id == $service->freelancer_id &&
            $user->hasAnyPermission(['order.reject', 'order.accept']);
    }

    /**
     * Determine whether the user can delete the model.
     */
    public function delete(User $user, ServiceOrder $serviceOrder): bool
    {
        $client = $user->client()->first();

        return $client->id == $serviceOrder->client_id;
    }
}
