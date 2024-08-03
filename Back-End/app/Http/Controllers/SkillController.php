<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Auth\Freelancer;
use App\Models\Skill;

class SkillController extends Controller
{

    public function list()
    {
        $Skills = Skill::all();
        return response()->json($Skills);
    }

    public function show(Skill $skill)
    {
        return response()->json(["skill" => Skill::find($skill->id)]);
    }
    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string|max:255'
        ]);

        $skill = Skill::create($data);

        return response()->json([
            'message' => 'Skill created successfully',
            'skill' => $skill
        ]);
    }

    /**
     * connect skill with freelancer
     */
    public function addSkill(Request $request)
    {
        $request->validate([
            'name' => 'required',
        ]);

        $skill = Skill::where('name', $request->name)->first();

        $freelancer = auth()->user()->freelancer()->first();

        $freelancer->skills()->attach($skill->id);

        return response()->json(['message' => 'Skill added successfully'], 200);
    }

    /**
     * Display the specified resource.
     */
    public function removeSkill(Request $request)
    {
        $request->validate([
            'skill_id' => 'required|exists:skills,id',
        ]);
        $freelancerId = auth()->user()->freelancer()->first();

        $skill = Skill::where('name', $request->name)->first();

        $freelancer = Freelancer::findOrFail($freelancerId->id);

        $freelancer->skills()->detach($skill->id);

        return response()->json(['message' => 'Skill removed successfully'], 200);
    }



    public function destroy(Skill $skill)
    {
        $skill->delete();
        return response()->json(['message' => 'Skill delete Sccessfully']);
    }
    public function search(Request $request)
    {
        $filters = $request->only('name');
        $skill = Skill::filter($filters)->get();
        return response()->json($skill);
    }
}
