<?php

namespace App\Http\Controllers;

use App\Models\Auth\Client;
use App\Models\Contract;
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
   


    public function allOrderClient()
    {
        $user = auth()->user();
        $clientId = $user->client->id;
        $orders = ServiceOrder::where('client_id', $clientId)->get();
        return response()->json($orders);
    }

    public function allOrderFreelancer()
    {
        $user = auth()->user();
        $FreelancertId = $user->freelancer->id;
        $orders = ServiceOrder::where('freelancer_id', $FreelancertId)->get();
        return response()->json($orders);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        $service_id = $request->service_id;
        $service = ServiceOrder::find($service_id);
        $user = auth()->user();


        $data = $request->validate([
            'delivery_date' => 'required|date',
            'amount' => 'required|numeric',
        ]);
        $data['status'] = 'pinding';
        $data['order_date'] = now();
        $data['service_id'] = $service_id;
        $data['total'] = request()->amount * $service->price;
        $data['client_id'] = $user->client->id;
        ServiceOrder::create($data);

        return response()->json(['message' => 'Order sent Successfuly', 'Order' => $data]);
    }
    public function makeContract(Request $request, ServiceOrder $order)
    {
        $Contract = new ContractController();
        $Contract->createContractService($request, $order);
    }



    /**
     * Display the specified resource.
     */
    public function show(ServiceOrder $serviceOrder)
    {
        return response()->json(ServiceOrder::find($serviceOrder));
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(ServiceOrder $serviceOrder)
    {
        if ($serviceOrder->status === 'complete') {
            return response()->json(['message' => 'you can not delete ']);
        } else {
            ServiceOrder::findOrFail($serviceOrder);
            $serviceOrder->delete();
            return response()->json(['meesage' => 'Order delete Sccessfully']);
        }
    }
}
