<?php

namespace App\Http\Controllers;

use App\Models\Skill;
use Illuminate\Http\Request;
use App\Models\Auth\Freelancer;

class SkillController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return response()->json(["skill"=>Skill::all()]);
    }
    public function show(Skill $skill)
    {
        return response()->json(["skill"=>Skill::find($skill->id)]);
    }
    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        $data=$request->validate([
            'name'=>'required|string|max:255'
        ]);
        Skill::create($data);
        return response()->json([
            'message'=>'Skill Create Sccessfully',
            'Skill'=>$data
        ]);
    }

    /**
     * connect skill with freelancer
     */
    public function addSkill(Request $request)
    {
        $request->validate([
            'skill_id' => 'required|exists:skills,id',
        ]);
        $freelancer=auth()->user();
        
        

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
    

   
    public function destroy(Skill $skill)
    {
        $skill->delete();
        return response()->json(['message'=>'Skill delete Sccessfully']);
    }
}
