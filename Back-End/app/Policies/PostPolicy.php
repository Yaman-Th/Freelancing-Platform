<?php

namespace App\Policies;

use App\Models\Post;
use App\Models\Auth\User;
use Illuminate\Auth\Access\Response;

class PostPolicy
{

    /**
     * Determine whether the user can create models.
     */
    public function create(User $user)
    {
        if ($user->hasPermissionTo('post.create'))
            return true;
        else return false;
    }

    /**
     * Determine whether the user can update the model.
     */
    public function update(User $user, Post $post): bool
    {
        $client = $user->client()->first();
        if ($user->hasPermissionTo('post.update') && $client->id == $post->client_id)
            return true;
        else return false;
    }

    /**
     * Determine whether the user can delete the model.
     */
    public function delete(User $user, Post $post): bool
    {
        $client = $user->client()->first();
        if ($user->hasPermissionTo('post.delete') && $client->id == $post->client_id)
            return true;
        else return false;
    }
}
