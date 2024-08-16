<?php

namespace App\Http\Controllers;

use App\Models\Contract;
use App\Models\Proposal;
use App\Models\Auth\User;
use Illuminate\Http\Request;
use App\Models\Auth\Freelancer;
use App\Models\Post;
use Dotenv\Exception\ValidationException;

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
        $user = auth()->user();
        $freelancer = $user->freelancer;
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
    public function acceptProposal(Request $request)
    {
        $proposal=Proposal::find($request->proposal_id);
        $proposal->update([
            'status' => 'accepted',
        ]);
        $proposal->save();
        $post = Post::find($proposal->post_id);
        $client = auth()->user()->client()->first()->id;
        $contract = Contract::create([
            'post_id' => $post->id,
            'client_id' => $post->client_id,
            'freelancer_id'=> $proposal->freelancer_id,
            'status' => 'active',
            'end_date' => '2002-5-2',
            'payment_status' => 'pending',
            'payment_amount' => 100
        ]);
        return response()->json(['proposel' => $proposal,'contract'=>$contract]);;
    }

    // Reject Proposal
    public function rejectProposal(Request $request)
    {
        $proposal=Proposal::find($id)->first();
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
