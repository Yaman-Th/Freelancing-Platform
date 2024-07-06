<?php

namespace App\Http\Controllers;

use App\Models\Auth\Client;
use App\Models\Service;
use App\Models\ServiceOrder;
use Carbon\Carbon;
use Illuminate\Http\Request;

class ServiceOrderController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $orders = ServiceOrder::all();
        return response()->json($orders);
    }


    public function getOrderClient()
    {
        $client = auth()->user()->client()->first();
        $orders = ServiceOrder::where('client_id', $client->id)->get();
        return response()->json($orders);
    }

    // public function allOrderFreelancer()
    // {
    //     $user = auth()->user();
    //     $FreelancertId = $user->freelancer->id;
    //     $orders = ServiceOrder::where('freelancer_id', $FreelancertId)->get();
    //     return response()->json($orders);
    // }

    /**
     * Show the form for creating a new resource.
     */
    public function store(Request $request)
    {
        $id = request('service_id');
        $service = Service::find($id);
        $user = auth()->user();


        $data = $request->validate([
            'service_id' => 'required|numeric',
            // 'order_date' => 'required|date',
            'delivery_date' => 'required|date',
            'total_amount' => 'required|numeric',
        ]);
        // $data['service_id'] = $service->id;
        // $data['total'] = request()->amount * $service->price;
        // $user = auth()->user();
        // $data['client_id'] = $user->client->id;

        $order = ServiceOrder::create([
            'service_id' => request('service_id'),
            'client_id' => auth()->user()->client()->first()->id,
            'order_date' => today()->format('Y-m-d'),
            'delivery_date' => request('delivery_date'),
            'status' => 'pending',
            'total_amount' => request('total_amount')
        ]);

        return response()->json(['message' => 'Order sent Successfuly', 'Order' => $order]);
    }


    /**
     * Display the specified resource.
     */
    public function show(ServiceOrder $serviceOrder)
    {
        $serviceOrder = ServiceOrder::find($serviceOrder->id);
        return response()->json([$serviceOrder]);
    }

    // Accept SerivceOrder
    public function acceptOrder(ServiceOrder $serviceOrder)
    {
        $serviceOrder->update([
            'status' => 'accepted',
        ]);
    }

    // Reject ServiceOrder
    public function rejectOrder(ServiceOrder $serviceOrder)
    {
        $serviceOrder->update([
            'status' => 'rejected',
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(ServiceOrder $serviceOrder)
    {
        if ($serviceOrder->status === 'complete') {
            return response()->json(['message' => 'You can not delete']);
        } else {
            // ServiceOrder::findOrFail($serviceOrder);
            $serviceOrder->delete();
            return response()->json(['meesage' => 'Order deleted Successfully']);
        }
    }
}
