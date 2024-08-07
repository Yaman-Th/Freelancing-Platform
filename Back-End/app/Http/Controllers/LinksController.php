<?php

namespace App\Http\Controllers;

use App\Models\Links;
use Illuminate\Http\Request;
use App\Http\Requests\StoreLinksRequest;
use App\Http\Requests\UpdateLinksRequest;

class LinksController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $user = auth()->user()->id;
        $myLinks = Links::where('user_id', $user)->get();
        return response()->json(['myLinks' => $myLinks]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        $user = auth()->user()->id;
        $newLink = $request->validate([
            'links' => 'required',
            'type' => 'required'
        ]);
        $newLink['user_id']=$user;
        Links::create($newLink);
        return response()->json('created Successfuly');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreLinksRequest $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(Links $links)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Links $links)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateLinksRequest $request, Links $links)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Links $links)
    {
        $links->delete();
        return response()->json('deleted Successfuly');
    }
}
