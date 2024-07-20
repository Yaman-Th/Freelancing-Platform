<?php

namespace App\Http\Controllers;

use App\Models\Auth\Freelancer;
use App\Models\Auth\User;
use App\Models\Proposal;
use Illuminate\Http\Request;

class ProposalController extends Controller
{
    // Get All Proposals
    public function index()
    {
        $proposals = Proposal::all();

        return response()->json([$proposals], 200);
    }

    // Store New Proposal
    public function store(Request $request)
    {
        $freelancer = auth()->user()->freelancer()->first();
        try {
            $request->validate([
                'post_id' => 'required|numeric',
                'comment' => 'string',
            ]);
        } catch (ValidationException $exception) {
            return response()->json([
                'message' => 'Validation Error',
                'errors' => $exception->errors()
            ], 422);
        }

        $proposal = Proposal::create([
            'post_id' => request('post_id'),
            'freelancer_id' => $freelancer->id,
            'comment' => request('comment'),
            'status' => 'pending',
            'date' => today()->format('Y-m-d')
        ]);

        return response()->json([
            'message' => 'Proposal Created Successfuly',
            'post' => $proposal
        ], 200);
    }

    // Get Proposal By id
    public function show(Proposal $proposal)
    {
        $proposal = Proposal::find($proposal->id);
        return response()->json(['proposal' => $proposal], 200);
    }


    // Accept Proposal
    public function acceptProposal(Proposal $proposal)
    {
        $proposal->update([
            'status' => 'accepted',
        ]);
    }

    // Reject Proposal
    public function rejectProposal(Proposal $proposal)
    {
        $proposal->update([
            'status' => 'rejected',
        ]);
    }

    // Update Proposal
    public function update(Request $request, Proposal $proposal)
    {
        if ($proposal['status'] === 'pending') {

            $proposal->update([
                'comment' => request('comment'),
            ]);
            return response()->json(['message' => 'Proposal updated successfuly'], 204);
        }
        return response()->json(['message' => 'You cannot edit this proposal right now'], 500);
    }

    // Delete Proposal
    public function destroy(Proposal $proposal)
    {
        $proposal->delete();
        return response()->json(['Proposal Deleted Successfuly'], 200);
    }
}
