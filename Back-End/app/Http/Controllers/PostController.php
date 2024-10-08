<?php

namespace App\Http\Controllers;

use App\Models\Auth\Client;
use App\Models\Category;
use App\Models\Post;
use App\Models\Proposal;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
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
        $client = auth()->user()->client()->first();

        try {
            $request->validate([
                'categoryName' => 'required',
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
            'client_id' => $client->id,
            'category_id' => Category::where('name','like',request('categoryName'))->first()->id,
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
        return response()->json(['Post Deleted Successfuly'], 200);
    }

    // Get Proposals
    public function getProposals(Post $post)
    {
        $proposals = $post->proposals()->with('freelancer')->get();
        return response()->json($proposals, 200);
    }
    public function getmypost(Request $request)
    {
        $client = auth()->user()->client()->first();

        $mypost = Post::where('client_id', $client->id)->get();
        return response()->json($mypost);
    }
    public function getpostsbyid($clientId)
    {

        $mypost = Post::where('client_id', $clientId)->get();
        return response()->json($mypost);
    }
    public function totalProject()
    {
        $count = DB::table('posts')->count('id');
        return response()->json(["The total post" => $count]);
    }
}
