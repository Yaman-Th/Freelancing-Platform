<?php

namespace App\Http\Controllers;

use App\Models\Service;
use App\Models\Category;
use App\Models\Auth\User;
use Illuminate\Http\Request;
use App\Models\Auth\Freelancer;
use Illuminate\Support\Facades\DB;
use Spatie\QueryBuilder\QueryBuilder;
use Spatie\QueryBuilder\AllowedFilter;
use Illuminate\Validation\ValidationException;

class ServiceController extends Controller
{

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $services = Service::all()->map(function ($service) {
            return [
                'id' => $service->id,
                'title' => $service->title,
                'description' => $service->description,
                'price' => $service->price,
                'category' => Category::find($service->category_id)->name,
                'image_url' => url('storage/' . $service->image),
            ];
        });

        return response()->json(['services' => $services], 200);
    }

    /**
     * Show one item by id
     */
    public function show($id)
    {
        $servic = Service::find($id);
        if (!$servic) {
            return response()->json(['message' => 'Service not found'], 404);
        }

        $category = Category::find($servic->category_id)->name;

        return response()->json([
            'service' => $servic,
            'category' => $category,
            'image_url' => url('storage/' . $servic->image),
        ], 201);
    }


    /**
     * Show the form for creating a new resource.
     */
    public function store(Request $request, Freelancer $freelancer)
    {
        try {
            $validatedData = $request->validate([
                'title' => 'required|max:255',
                'description' => 'required|max:255',
                // 'image' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
                'delivery_dayes' => 'required|numeric',
                'price' => 'required|numeric',
                'category_name' => 'required',
            ]);
            $validatedData['category_id'] = Category::where('name', 'like', $request->category_name)->first()->id;


            if ($request->hasFile('image')) {
                $imagePath = $request->file('image')->store('images', 'public');
                $validatedData['image'] = $imagePath;
            }

            $user = auth()->user();
            $validatedData['freelancer_id'] = $user->freelancer->id;
            $service = Service::create($validatedData);
            $category = Category::find($validatedData['category_id']);

            return response()->json(['Message' => 'Service created successfully', 'Service' => $service, 'Category' => $category['name']]);
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
            $data = $request->validate([
                'title' => 'sometimes|max:255',
                'description' => 'sometimes|max:255',
                // 'image' => 'sometimes|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
                'delivery_days' => 'sometimes|numeric',
                'price' => 'sometimes|numeric',
                'category_id' => 'sometimes|numeric',
            ]);


            $freelancer = auth()->user()->freelancer()->first();
            if (!$freelancer) {
                return response()->json(['message' => 'Freelancer not found'], 404);
            }

            // $services = $freelancer->service()->find($service);
            if (!$service) {
                return response()->json(['message' => 'Service not found or not owned by freelancer'], 404);
            }

            $service->update([
                'title' => $request['title'],
                'description' => $request['description'],
                'image' => 'sometimes|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
                'delivery_days' => $request['delivery_days'],
                'price' => $request['price'],
                'category_id' => $request['category_id'],
            ]);

            return response()->json(['message' => 'Service updated successfully', 'service' => $service]);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Error updating service', 'error' => $e->getMessage()], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Service $service)
    {
        try {

            $freelancer = auth()->user()->freelancer()->first();


            if (!$freelancer) {
                return response()->json(['message' => 'Freelancer not found'], 404);
            }


            $services = $freelancer->service()->find($service);

            if (!$services) {
                return response()->json(['message' => 'Service not found or not owned by freelancer'], 404);
            }

            $service->delete();

            return response()->json(['message' => 'Service deleted successfully']);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Error deleting service', 'error' => $e->getMessage()], 500);
        }
    }


    public function myservice(Request $request)
    {
        $user = auth()->user();
        $freelancer = $user->freelancer()->first();
        $myservice = Service::where('freelancer_id', 'like', $freelancer->id)->get();
        return response()->json($myservice);
    }

    public function search(Request $request)
    {
        $data = $request->only(['title', 'description', 'delivery_dayes', 'price', 'category', 'ratings']);
        $services = Service::filter($data)->get();
        return response()->json(["The Services" => $services]);
    }

    public function totalService()
    {
        $count = DB::table('services')->count('id');
        return response()->json(["The total Services" => $count]);
    }
}
