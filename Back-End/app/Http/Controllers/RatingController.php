<?php

namespace App\Http\Controllers;

use App\Models\Rating;
use App\Models\ServiceUsage;
use Illuminate\Http\Request;

class RatingController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function ratingService($service)
    {

        $ratings = Rating::where('service_id', $service);

        return response()->json($ratings);
    }

    public function show($id)
    {
        $rating = Rating::findOrFail($id);
        return response()->json($rating);
    }



    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        $data = $request->validate([
            'comment' => 'sometimes|string',
            // 'post_id' => 'requred|mumeric',
            'service_id' => 'required|numeric',
            'score' => 'required|numeric|min:1|max:5'
        ]);
        $user = auth()->user();
        $data['client_id'] = $user->client->id;

        $serviceUsage = ServiceUsage::where('client_id', $data['client_id'])
            ->where('service_id', $data['service_id'])
            ->first();

        if (!$serviceUsage) {
            return response()->json(['error' => 'You can only rate a service after using it.'], 403);
        }

        $rating = Rating::create($data);

        return response()->json($rating, 201);
    }

    public function destroy($id)
    {
        $rating = Rating::findOrFail($id);
        $rating->delete();

        return response()->json(null, 204);
    }
}
