<?php

namespace App\Http\Controllers;

use App\Models\Team;
use App\Models\Auth\User;
use App\Models\TeamMember;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;


class TeamController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return response()->json(Team::all());
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|String|max:255'
        ]);

        $data['client_id'] = auth()->user()->client()->first()->id;
        $team = Team::create($data);
        return response()->json(['message' => 'The Team Created Sccussfuly', 'Team data' => $data]);
    }

    public function sendRequest(Request $request)
    {
        $data = $request->validate([
            'team_id' => 'required|numeric',
            'freelancer_id' => 'required|numeric',
            'message' => 'required|String'
        ]);
        $data['name'] = Team::find($data['team_id']);
        //add notifcation 
        //add response
        return response()->json($data);
    }
    public function addmember(Request $request)
    {
        $data = $request->validate([
            'team_id' => 'required'
        ]);
        $data['freelancer_id'] = auth()->user()->freelancer()->first()->id;
        $accept = TeamMember::create($data);
        return response()->json(['message' => ' you are in Team', 'data' => $data]);
    }
    /**
     * Display the specified resource.
     */
    public function show(Team $team)
    {
        return response()->json(Team::find($team));
    }
    
    public function showMyTeams()
    {
        $client=auth()->user()->client()->first()->id;
        $myTeams=  DB::table('teams')
        ->where('client_id', $client)
        ->pluck('name');
        return response()->json(['Your Teams is '=>$myTeams]);
    }
    

    public function destroy(Team $team)
    {
        return response()->json(['message' => 'Team message Sccussfuly']);
    }
}
