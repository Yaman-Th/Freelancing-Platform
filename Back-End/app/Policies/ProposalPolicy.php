<?php

namespace App\Policies;

use App\Models\Proposal;
use App\Models\Auth\User;
use Illuminate\Auth\Access\Response;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;
use Throwable;

class ProposalPolicy
{

    /**
     * Determine whether the user can create models.
     */
    public function create(User $user): bool
    {
        return $user->hasPermissionTo('proposal.create');
    }

    public function update(User $user, Proposal $proposal): bool
    {
        $freelancer = $user->freelancer()->first();
        if ($user->hasPermissionTo('proposal.update') && $freelancer->id == $proposal->freelancer_id)
            return true;
        else return false;
    }

    /**
     * Determine whether the user can update the model.
     */
    public function updateStatus(User $user, Proposal $proposal): bool
    {
        $client = $user->client()->first();
        $post = $proposal->post()->first();

        return $post->id == $proposal->post_id &&
            $client->id == $post->client_id &&
            $user->hasAnyPermission(['proposal.reject', 'proposal.accept']);
    }

    /**
     * Determine whether the user can delete the model.
     */
    public function delete(User $user, Proposal $proposal): bool
    {
        $freelancer = $user->freelancer()->first();

        return $freelancer->id == $proposal->freelancer_id;
    }
}
