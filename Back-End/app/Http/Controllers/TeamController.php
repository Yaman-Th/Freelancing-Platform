<?php

namespace App\Http\Controllers;

use App\Models\Team;
use App\Models\Auth\User;
use App\Models\TeamMember;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;


class TeamController extends Controller
{
    public function index()
    {
        $teams = auth()->user()->teams;
        return response()->json($teams);
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255'
        ]);

        $team = auth()->user()->client()->teams()->create([
            'name' => $request->name
        ]);

        return response()->json($team, 201);
    }

    public function show($id)
    {
        $team = Team::with('members')->findOrFail($id);
        return response()->json($team);
    }

    public function update(Request $request, $id)
    {
        $team = Team::findOrFail($id);

        $request->validate([
            'name' => 'sometimes|required|string|max:255',
        ]);

        $team->update($request->all());

        return response()->json($team);
    }

    public function destroy($id)
    {
        $team = Team::findOrFail($id);
        $team->delete();

        return response()->json(null, 204);
    }
}
