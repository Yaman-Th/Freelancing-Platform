<?php

namespace App\Http\Controllers;

use App\Models\Auth\Client;
use App\Models\Contract;
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
        return response()->json(ServiceOrder::all());
    }
    public function show(ServiceOrder $serviceOrder)
    {
        $serviceOrder = ServiceOrder::find($serviceOrder->id);
        return response()->json([$serviceOrder]);
    }



    public function getOrderClient()
    {
        $client = auth()->user()->client()->first();
        $orders = ServiceOrder::where('client_id', $client->id)->get();
        return response()->json(['your orders are' => $orders]);
    }

    // public function getOrderFreelancer()
    // {
    //     $user = auth()->user();
    //     $FreelancertId = $user->freelancer->id;
    //     $orders = ServiceOrder::where('freelancer_id', $FreelancertId)->get();
    //     return response()->json($orders);
    // }


    public function create(Request $request)
    {
        $order = ServiceOrder::create([
            'service_id' => $request->service_id,
            'client_id' => auth()->user()->client()->first()->id,
            'details' => $request->details,
            'quantity' => $request->quantity,
            'delivery_date' => $request->delivery_date,
            'status' => 'pending'
        ]);

        return response()->json(['message' => 'Order created successfully!', 'order' => $order]);
    }

    public function approve($orderId)
    {
        $order = ServiceOrder::find($orderId);
        $service = Service::find($order->service_id);
        if ($order) {
            $order->update(['status' => 'approved']);
            $contract = Contract::create([
                'service_order_id' => $order->id,
                'client_id' => $order->client_id,
                'freelancer_id' => $service->freelancer_id,
                'status' => 'active',
                'end_date' => $order->delivery_date,
                'payment_status' => 'pending',
                'payment_amount' => $order->quantity * $service->price
            ]);

            return response()->json(['message' => 'Order approved and contract created!', 'contract' => $contract]);
        }

        return response()->json(['message' => 'Order not found!'], 404);
    }

    public function reject($orderId)
    {
        $order = ServiceOrder::find($orderId);

        if ($order) {
            $order->update(['status' => 'rejected']);
            return response()->json(['message' => 'Order rejected!']);
        }

        return response()->json(['message' => 'Order not found!'], 404);
    }

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
