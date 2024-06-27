<?php

namespace App\Http\Controllers;

use App\Models\Post;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;

class PostController extends Controller
{
    // Get All Posts
    public function index()
    {
        $posts = Post::all();
        return response()->json([$posts], 200);
    }

    // Store New Posts
    public function store(Request $request)
    {
        try {
            $request->validate([
                'client_id' => 'required|numeric',
                'title' => 'required|string',
                'description' => 'required|string',
                'type' => 'required|string',
                'budget' => 'required|numeric',
                'deadline' => 'required|date'
            ]);
        } catch (ValidationException $exception) {
            return response()->json([
                'message' => 'Validation Error',
                'errors' => $exception->errors()
            ], 422);
        }

        $post = Post::create([
            'client_id' => request('client_id'),
            // 'category_id' => request('category_id'),
            // 'team_id' => request('team_id'),
            'title' => request('title'),
            'description' => request('description'),
            'type' => request('type'),
            'budget' => request('budget'),
            'deadline' => request('deadline')
        ]);

        return response()->json([
            'message' => 'Post Created Successfuly',
            'post' => $post
        ], 200);
    }

    // Get Post By id
    public function show(Post $post)
    {
        $post = Post::find($post->id);
        return response()->json(['post' => $post], 200);
    }


    // Update Post
    public function update(Request $request, Post $post)
    {
        $post->update([
            'title' => request('title'),
            'description' => request('description'),
            'type' => request('type'),
            'budget' => request('budget'),
            'deadline' => request('deadline')
        ]);
        return response()->json($post, 204);
    }

    // Delete Post
    public function destroy(Post $post)
    {
        $post->delete();
    }
}
