<?php

namespace App\Http\Controllers;

use App\Models\Auth\User;
use App\Models\Rating;
use App\Models\Service;
use App\Models\ServiceOrder;
use App\Models\Post;
use Illuminate\Http\Request;

class RatingController extends Controller
{
    public function index()
    {
        $ratings = Rating::all();
        return response()->json($ratings);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'service_order_id' => 'nullable|exists:service_orders,id',
            'post_id' => 'nullable|exists:posts,id',
            'score' => 'required|integer|between:1,5',
            'comment' => 'nullable|string',
        ]);

        // Ensure at least one of order_id or post_id is provided
        if (!$request->filled('service_order_id') && !$request->filled('post_id')) {
            return response()->json(['error' => 'Order ID or Post ID is required'], 422);
        }

        // Check if rating already exists for the service order
        if ($request->filled('service_order_id')) {
            $order = ServiceOrder::findOrFail($request->service_order_id);
            $service = Service::findOrFail($order->service_id);

            // Ensure the service is completed
            if ($order->status !== 'completed') {
                return response()->json(['error' => 'Order is not completed yet'], 422);
            }

            // Check if rating already exists
            $existingRating = Rating::where('service_order_id', $request->service_order_id)
                ->where('rater_id', auth()->user()->id)
                ->first();

            if ($existingRating) {
                return response()->json(['error' => 'Rating already exists for this service order'], 422);
            }

            // Set rater and ratee IDs
            $data['rater_id'] = auth()->user()->id;  // Assuming the rater is the authenticated user
            $data['ratee_id'] = $service->freelancer->user_id;  // Assuming the ratee is the freelancer
        }

        // Check if rating already exists for the post
        if ($request->filled('post_id')) {
            $post = Post::findOrFail($request->post_id);

            // Ensure the post is completed
            if ($post->status !== 'completed') {
                return response()->json(['error' => 'Post is not completed yet'], 422);
            }

            // Check if rating already exists
            $existingRating = Rating::where('post_id', $request->post_id)
                ->where('rater_id', auth()->id())
                ->first();

            if ($existingRating) {
                return response()->json(['error' => 'Rating already exists for this post'], 422);
            }

            // Set rater and ratee IDs
            $data['rater_id'] = auth()->user()->id;  // Assuming the rater is the authenticated freelancer
            $data['ratee_id'] = $post->client->user_id;  // Assuming the ratee is the client
        }

        // Create the rating
        if ($request->filled('service_order_id')) {
            $order = ServiceOrder::findOrFail($request->service_order_id);
            $service = Service::findOrFail($order->service_id);
            if ($service->ratings == 0) {
                $service->ratings = $request->score;
                $service->save();
            } else {
                $service->ratings = ($service->ratings + $request->score) / 2;
                $service->save();
            }
        }
        $rating = Rating::create($data);

        return response()->json($rating, 201);
    }



    public function show($id)
    {
        $rating = Rating::findOrFail($id);
        return response()->json($rating);
    }

    public function update(Request $request, $id)
    {
        $rating = Rating::findOrFail($id);

        $data = $request->validate([
            'service_id' => 'nullable|exists:services,id',
            'post_id' => 'nullable|exists:posts,id',
            'score' => 'required|integer|between:1,5',
            'comment' => 'nullable|string',
            // 'rater_id' => 'required',
            // 'ratee_id' => 'required',
        ]);

        // Verify the service or post is completed (if updating related IDs)
        if ($request->filled('service_id') && $request->service_id != $rating->service_id) {
            $data['rater_id'] = auth()->user()->client()->first()->id;
            $service = Service::findOrFail($request->service_id);
            $data['ratee_id'] = $service->freelancer_id;
            if ($service->status !== 'completed') {
                return response()->json(['error' => 'Service is not completed yet'], 422);
            }
        }

        if ($request->filled('post_id') && $request->post_id != $rating->post_id) {
            $data['rater_id'] = auth()->user()->freelancer()->first()->id;
            $post = Post::findOrFail($request->post_id);
            $data['ratee_id'] = $service->client_id;
            if ($post->status !== 'completed') {
                return response()->json(['error' => 'Post is not completed yet'], 422);
            }
        }

        $rating->update($data);

        return response()->json($rating);
    }

    public function destroy($id)
    {
        $rating = Rating::findOrFail($id);
        $rating->delete();

        return response()->json(null, 204);
    }



    public function getServiceRatings($serviceId)
    {
        $ratings = Rating::whereHas('service_order', function ($query) use ($serviceId) {
            $query->where('service_id', $serviceId);
        })->get();

        return response()->json($ratings);
    }


    public function getPostRatings($postId)
    {
        $ratings = Rating::where('post_id', $postId)->get();

        return response()->json($ratings);
    }


    public function getUserRatings($userId)
    {
        $ratings = Rating::where('ratee_id', $userId)->get();

        return response()->json($ratings);
    }
}
