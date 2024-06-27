<?php

namespace App\Http\Controllers;

use App\Models\Service;
use App\Models\Category;
use Illuminate\Http\Request;
use App\Models\Auth\Freelancer;
use App\Models\Auth\User;
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
    public function show($service)
    {
        return response()->json(['service'=>Service::find($service)]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function addService(Request $request, Freelancer $freelancer)
    {
        try {
            $validatedData= $request->validate([
                'title' => 'required|max:255',
                'description' => 'required|max:255',
                'image' => 'sometimes|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
                'delivery_dayes' => 'required|numeric',
                'price' => 'required|numeric',
                'category_id' => 'required|numeric',
            ]);


            if ($request->hasFile('image')) {
                $imagePath = $request->file('image')->store('image');
                $validatedData['image'] = $imagePath;
            }

            $user=auth()->user();
            $validatedData['freelancer_id'] = $user->freelancer->id;

            $service = Service::create($validatedData);

            return response()->json(['Message' => 'Service created successfully', 'Service' => $service ]);

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
    public function edit(Request $request,$service)
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
            $user = auth()->user();

            // الحصول على الفريلانسر المتعلق بالمستخدم المصادق عليه
            $freelancer = $user->freelancer;
    
            // التحقق إذا كان الفريلانسر موجود
            if (!$freelancer) {
                return response()->json(['message' => 'Freelancer not found'], 404);
            }
    
            // العثور على الخدمة والتحقق من أنها تابعة لهذا الفريلانسر
            $service = $freelancer->services()->find($service);
    
            if (!$service) {
                return response()->json(['message' => 'Service not found or not owned by freelancer'], 404);
            }
     
            // تحديث معلومات الخدمة
            $service->update($request->only(['title', 'description', 'delivery_dayes','price']));
    
            return response()->json(['message' => 'Service updated successfully', 'service' => $service]);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Error updating service', 'error' => $e->getMessage()], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Service $serviceId)
    {
        try {
            // الحصول على المستخدم المصادق عليه حاليا
            $user = auth()->user();
    
            $freelancer = $user->freelancer;
    
            if (!$freelancer) {
                return response()->json(['message' => 'Freelancer not found'], 404);
            }
    
            $service = $freelancer->services()->find(5);
    
            if (!$service) {
                return response()->json(['message' => 'Service not found or not owned by freelancer'], 404);
            }
    
            $service->delete();
    
            return response()->json(['message' => 'Service deleted successfully']);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Error deleting service', 'error' => $e->getMessage()], 500);
        }
    }
}
