<?php

namespace App\Http\Controllers;

use App\Models\Auth\User;
use App\Models\Contract;
use App\Models\ServiceOrder;
use Illuminate\Http\Request;

class ContractController extends Controller
{

    public function index()
    {
        return response()->json(Contract::all());
    }
    public function show(Contract $contract)
    {
        Contract::find($contract);
    }

    public function updateStatus(Request $request, $id)
    {
        $contract = Contract::find($id);

        if ($contract) {
            $contract->update(['status' => $request->status]);
            return response()->json(['message' => 'Contract status updated successfully!', 'contract' => $contract]);
        }

        return response()->json(['message' => 'Contract not found!'], 404);
    }

    public function updatePaymentStatus(Request $request, $id)
    {
        $contract = Contract::find($id);

        if ($contract) {
            $contract->update(['payment_status' => $request->payment_status]);
            return response()->json(['message' => 'Contract payment status updated successfully!', 'contract' => $contract]);
        }

        return response()->json(['message' => 'Contract not found!'], 404);
    }

    public function getclientContracts()
    {
        $contracts = Contract::whereHas('service_order', function ($query) {
            $query->where('client_id', auth()->user()->client()->first()->id);
        })->get();

        return response()->json($contracts);
    }

    public function getfreelancerContracts()
    {
        $contracts = Contract::whereHas('order.service', function ($query) {
            $query->where('freelancer_id', auth()->user()->freelancer()->first()->id);
        })->get();

        return response()->json($contracts);
    }
}
