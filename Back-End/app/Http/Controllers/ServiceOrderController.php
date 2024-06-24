<?php

namespace App\Http\Controllers;

use App\Models\Auth\Client;
use App\Models\Service;
use App\Models\ServiceOrder;
use Illuminate\Http\Request;

class ServiceOrderController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return response()->json(ServiceOrder::all());
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request,Service $service,Client $client)
    {
        $data=$request->validate([
            'order_date'=>'required|date',
            'deliverr_date'=>'required|date',
            'total_amount'=>'required|numeric',

        ]);
        ServiceOrder::create($data);
        
        return response()->json(['message'=>'Order sent Successfuly','Order'=>$data]);
    }

    

    /**
     * Display the specified resource.
     */
    public function show(ServiceOrder $serviceOrder)
    {
        return response()->json( ServiceOrder::find($serviceOrder));
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(ServiceOrder $serviceOrder)
    {
        ServiceOrder::findOrFail($serviceOrder);
        $serviceOrder->delete();
        return response()->json(['meesage'=>'Order delete Sccessfully']);
    }
}
