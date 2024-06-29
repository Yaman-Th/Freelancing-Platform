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


    public function OrderClient()
    {
        $user = auth()->user();
        $clientId = $user->client->id;
        $orders = ServiceOrder::where('client_id', $clientId)->get();
        return response()->json($orders);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request, Service $service)
    {
        $data = $request->validate([
            'order_date' => 'required|date',
            'deliverr_date' => 'required|date',
            'total_amount' => 'required|numeric',

        ]);
        $user = auth()->user();
        $data['client_id'] = $user->client->id;
        ServiceOrder::create($data);

        return response()->json(['message' => 'Order sent Successfuly', 'Order' => $data]);
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
