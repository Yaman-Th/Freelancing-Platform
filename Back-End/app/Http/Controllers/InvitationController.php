<?php

namespace App\Http\Controllers;

use App\Models\Invitation;
use Illuminate\Http\Request;

class InvitationController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'team_id' => 'required|exists:teams,id',
            'freelancer_id' => 'required|exists:freelancers,id'
        ]);

        $invention = Invitation::create([
            'team_id' => $request->team_id,
            'freelancer_id' => $request->freelancer_id,
        ]);

        return response()->json(['message' => 'Invitation sent successfully.'], 201);
    }

    public function update(Request $request, Invitation $invention)
    {
        $request->validate([
            'status' => 'required|in:accepted,rejected'
        ]);

        $invention->update(['status' => $request->status]);

        if ($request->status == 'accepted') {
            $invention->team->freelancers()->attach($invention->freelancer_id);
        }

        return response()->json(['message' => 'Invitation updated successfully.'], 200);
    }
}
