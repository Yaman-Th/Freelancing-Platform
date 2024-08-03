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
    public function show(ServiceOrder $serviceOrder)
    {
        $serviceOrder = ServiceOrder::find($serviceOrder->id);
        return response()->json([$serviceOrder]);
    }



    public function getOrderClient()
    {
        $user = auth()->user();
        $client = $user->client()->first();

        // Check if the client exists
        if (!$client) {
            return response()->json(['message' => 'Client not found'], 404);

        }
        $orders = ServiceOrder::where('client_id', $client->id)->get();

        if ($orders->isEmpty()) {
            return response()->json(['message' => 'No orders found'], 200);
        }

        return response()->json(['your orders are' => $orders], 200);
    }
        public function getOrderFreelancer()
    {
        $user = auth()->user();

        // التحقق مما إذا كان المستخدم هو فريلانسر
        if (!$user->freelancer) {
            return response()->json(['message' => 'You are not a freelancer'], 403);
        }

        $freelancerId = $user->freelancer->id;

        // الحصول على الطلبات التي ترتبط بالخدمات التي يقدمها الفريلانسر
        $orders = ServiceOrder::whereHas('service', function ($query) use ($freelancerId) {
            $query->where('freelancer_id', $freelancerId);
        })->get();

        if ($orders->isEmpty()) {
            return response()->json(['message' => 'You do not have any orders'], 200);
        }

        return response()->json(['orders' => $orders], 200);
    }


    public function create(Request $request)
    {
        $data = $request->validate([
            'service_id' => 'required|numeric',
            'details' => 'required',
            'quantity' => 'required|numeric',
            'delivery_date' => 'required|date'
        ]);

        $data['status'] = 'pending';
        $data['client_id'] = 1;
        if ($data['delivery_date'] < now()) {
            return response()->json(['message' => 'The date not Corect']);
        }
        $order = ServiceOrder::create($data);

        return response()->json(['message' => 'Order created successfully!', 'order' => $order]);
    }

    public function approve($orderId)
    {
        $order = ServiceOrder::find($orderId);
        $service = Service::find($order->service_id);
        if ($order) {
            $order->update(['status' => 'accepted']);
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
    public function completeOrder(Request $request, $orderId)
    {

        $order = ServiceOrder::find($orderId);

        // Check if the order exists
        if (!$order) {
            return response()->json(['message' => 'Order not found'], 404);
        }

        // Update the order status to completed
        $order->status = 'completed';
        $order->save();

        // Return a success response
        return response()->json(['message' => 'Order completed successfully']);
    }
}
