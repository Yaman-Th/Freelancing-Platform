<?php

namespace App\Http\Controllers;

use App\Models\Service;
use App\Models\Category;
use Illuminate\Http\Request;
use App\Models\Auth\Freelancer;
use Illuminate\Validation\ValidationException;

class ServiceController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function listServices()
    {
        return response()->json(Service::all());
    }

    /**
     * Show one item by id
     */
    public function show(Service $service)
    {
        return response()->json($service);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function addService(Request $request, Freelancer $freelancer)
    {
        try {
            $validatedData = $request->validate([
                'title' => 'required|max:255',
                'description' => 'required|max:255',
                'image' => 'sometimes|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
                'delivery_days' => 'required|numeric',
                'price' => 'required|numeric',
                'category_id' => 'required|numeric',
            ]);

            if ($request->hasFile('image')) {
                $imagePath = $request->file('image')->store('image_service');
                $validatedData['image'] = $imagePath;
            }

            $validatedData['freelancer_id'] = $freelancer->id;

            $service = Service::create($validatedData);

            return response()->json(['Message' => 'Service created successfully', 'Service' => $service]);

        } catch (ValidationException $exception) {
            return response()->json([
                'message' => 'Validation Error',
                'errors' => $exception->errors()
            ], 422);
        }
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Request $request, Service $service)
    {
        try {
            $validatedData = $request->validate([
                'title' => 'sometimes|max:255',
                'description' => 'sometimes|max:255',
                'image' => 'sometimes|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
                'delivery_days' => 'sometimes|numeric',
                'price' => 'sometimes|numeric',
                'category_id' => 'sometimes|numeric',
            ]);

            if ($request->hasFile('image')) {
                $imagePath = $request->file('image')->store('image_service');
                $validatedData['image'] = $imagePath;
            }

            $service->update($validatedData);

            return response()->json($service);

        } catch (ValidationException $exception) {
            return response()->json([
                'message' => 'Validation Error',
                'errors' => $exception->errors()
            ], 422);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function deleteService(Service $service)
    {
        $service->delete();
        return response()->json(['Message' => 'Service deleted successfully']);
    }
}
