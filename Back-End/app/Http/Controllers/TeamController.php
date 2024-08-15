<?php

namespace App\Http\Controllers;

use App\Models\Auth\Freelancer;
use App\Models\Auth\Client;
use App\Models\Team;
use App\Models\Auth\User;
use App\Models\Invitation;
use App\Models\TeamMember;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;


class TeamController extends Controller
{
    public function create(Request $request)
    {
        $data = $request->validate(['name' => 'required|String']);
        $data['client_id'] = auth()->user()->client()->first()->id;

        $team = Team::create($data);
        return response()->json($team, 201);
    }

    public function sendRequest(Request $request)
    {
        // التحقق من صحة البيانات
        $data = $request->validate([
            'team_name' => 'required|string',
            // 'email' => 'required|email',
            'name' => 'required|string',
            'message' => 'required|string'
        ]);

        // الحصول على المستخدم بواسطة البريد الإلكتروني
        $user = User::where('name', 'like', $request->name)->first();
        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }
        
        $team = Team::where('name', 'like', '%'.$request->team_name.'%')->first();
        if (!$team) {
            return response()->json(['message' => 'Team not found'], 404);
        }
        

        // الحصول على معرّف الفريلانسر بواسطة معرّف المستخدم
        $freelancer = Freelancer::where('user_id','like',$user->id)->first();
        if (!$freelancer) {
            return response()->json(['message' => 'Freelancer not found'], 404);
        }

        $thereis=Invitation::where('freelancer_id','like',$freelancer->id)->where('team_id','like',$team->id)->first();
        if($thereis){
            return response()->json(['message' => 'Freelancer alreafy  sent invention'], 404);

        }

        // إنشاء طلب الفريق
        $teamRequest = Invitation::create([
            'team_id' => $team->id,
            'freelancer_id' => $freelancer->id,
            'message' => $data['message']
        ]);

        return response()->json(['message' => 'Invitation sent successfully', 'teamRequest' => $teamRequest], 201);
    }

    public function handleRequest(Request $request, $id)
    {
        $teamRequest = Invitation::findOrFail($id);
        $teamRequest->status = $request->status;
        $teamRequest->save();

        return response()->json($teamRequest);
    }
    // عرض الفرق الخاصة بالعميل
    public function getAuthenticatedFreelancerTeams()
    {
        $user = auth()->user();
        $freelancer = $user->freelancer()->first();

        if (!$freelancer) {
            return response()->json(['message' => 'Freelancer not found'], 404);
        }

        $teams = $freelancer->teams;

        return response()->json($teams);
    }

    public function getClientTeams()
    {
        $id = auth()->user()->client()->first()->id;
        $client = Client::findOrFail($id);
        $teams = $client->teams;

        return response()->json($teams);
    }
    public function getinvitation()
    {
        $freelancerId = auth()->user()->freelancer()->id;
        $myinvitation = Invitation::where('freelancer_id', $freelancerId);
        return response()->json(['myinvitation' => $myinvitation]);
    }

    public function getmembers($teamId)
    {
        // $client = auth()->user()->client()->id;
        $members = Invitation::where('team_id', $teamId)->where('status', 'accepted')->get();
        if (!$members)
            return response()->json(['message' => 'there is no members yet']);
        else {
            $nameTeam = Team::find($teamId);
            $owner_id = Client::find($nameTeam->client_id);
            $owner = User::find($owner_id->user_id);
            return response()->json([
                'Team Name' => $nameTeam->name,
                'owner' => $owner->name,
                'members' => $members
            ]);
        }
    }
    public function destroy($name){
        $team=Team::where('name','like','%'.$name.'%')->first();
        if (!$team) {
            return response()->json(['message' => 'team not found'], 404);
        }
        $team->delete();
        return response()->json(['message' => 'team deleted successfully']);

    }
    public function teamInvitation($name){
        $team = Team::where('name', 'like', $name)->first();
    
        $invitations = Invitation::where('team_id', $team->id)
            ->with('team:name') // قم بتحميل اسم الفريق
            ->get()
            ->map(function ($invitation) {
                return [
                    'id' => $invitation->id,
                    'name' => User::find(Freelancer::find($invitation->freelancer_id)->user_id)->name,
                    'status' => $invitation->status,
                    'created_at' => $invitation->created_at,
                    'updated_at' => $invitation->updated_at,
                ];
            });
    
        return response()->json(['team name'=> $team->name,'team invintion' => $invitations ]);
    }
   

}
