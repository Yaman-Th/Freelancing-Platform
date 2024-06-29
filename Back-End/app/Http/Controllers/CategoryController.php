<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;

class CategoryController extends Controller
{
    // Get All Categories With Sub-Categories
    public function index()
    {
        $categories = Category::whereNull('parent_id')->with('children')->get();
        return  response()->json($categories, 200);
    }

    // Create New Category or Sub-Category
    public function store(Request $request)
    {
        try {
            $request->validate([
                'name' => 'required|string|max:255',
                'parent_id' => 'nullable|exists:categories,id',
            ]);
        } catch (ValidationException $e) {
            return response()->json([
                'message' => 'Validation Error',
                'error' => $e->errors()
            ], 422);
        }

        $category = Category::create([
            'name' => $request->name,
            'parent_id' => $request->parent_id,
        ]);

        return response()->json([$category], 200);
    }

    public function destroy(Category $category)
    {
        $category->delete();
        return response()->json(['Category Deleted Successfuly'], 200);
    }
}
