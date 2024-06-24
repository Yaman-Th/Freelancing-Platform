<?php

namespace App\Http\Controllers;

use App\Models\Skill;
use Illuminate\Http\Request;
use App\Models\Auth\Freelancer;
use App\Http\Requests\StoreSkillRequest;
use App\Http\Requests\UpdateSkillRequest;

class SkillController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return response()->json(["skill"=>Skill::all()]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        Skill::create(['name'=>request('name')]);
    }

    /**
     * connect skill with freelancer
     */
    public function addSkill(Request $request, $freelancerId)
    {
        $request->validate([
            'skill_id' => 'required|exists:skills,id',
        ]);

        $freelancer = Freelancer::findOrFail($freelancerId);

        $freelancer->skills()->attach($request->skill_id);

        return response()->json(['message' => 'Skill added successfully'], 200);
    }

    /**
     * Display the specified resource.
     */
   public function removeSkill(Request $request, $freelancerId)
    {
        $request->validate([
            'skill_id' => 'required|exists:skills,id',
        ]);

        $freelancer = Freelancer::findOrFail($freelancerId);

        $freelancer->skills()->delete($request->skill_id);

        return response()->json(['message' => 'Skill removed successfully'], 200);
    }
    

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Skill $skill)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateSkillRequest $request, Skill $skill)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Skill $skill)
    {
        //
    }
}
