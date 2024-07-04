<?php

namespace App\Http\Controllers;
use App\Models\Auth\User;
use App\Models\Contract;
use App\Models\ServiceOrder;
use Illuminate\Http\Request;

class ContractController extends Controller
{
    public function index(){
        return response()->json(Contract::all());
    }
    public function show(Contract $contract){
        Contract::find($contract);
    }


    public function createContractService(Request $request,$serviceorder_id){
        $serviceorder = ServiceOrder::find($serviceorder_id);
        $data['freelancer_id']=$serviceorder->freelancer_id;        
        $data['payment_amount']=$serviceorder->total;
        $data['client_id']=auth()->user()->client()->id;

        Contract::create($data);
        return response()->json(['message'=>'Contract Created Sccessfully','Contract'=>$data]);
    }
}
