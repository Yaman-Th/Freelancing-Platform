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
        $serviceorder =ServiceOrder::find($serviceorder_id);
        $payment_url=new paymentController(); 
        $data['freelancer_id']=2;
        $data['type']='hello';
        $data['status']='no';
        $data['service_order_id']=$serviceorder_id;        
        $data['payment_amount']=$serviceorder->total;
        $data['end_date']=$serviceorder->delivery_date;
        $data['client_id']=1;
        $data['url']=$payment_url->pay($request,$serviceorder->id);

        Contract::create($data);
        return response()->json(['message'=>'Contract Created Sccessfully','Contract'=>$data]);
    }
}
