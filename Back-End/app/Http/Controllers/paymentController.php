<?php

namespace App\Http\Controllers;

use App\Models\payment;
use App\Models\Contract;
use App\Models\Service;
use App\Models\ServiceOrder;
use Illuminate\Http\Request;

class PaymentController extends Controller
{

    public function getPaymentDetails($contractId)
    {
        $contract = Contract::find($contractId);
        $serviceOrder = ServiceOrder::find($contract->service_order_id);
        $service = Service::find($serviceOrder->service_id);

        if ($contract) {
            $totalAmount = $contract->payment_amount;
            return response()->json([
                'contract_id' => $contract->id,
                'total_amount' => $totalAmount,
                'order_details' => $serviceOrder
            ]);
        }

        return response()->json(['message' => 'Contract not found!'], 404);
    }

    // معالجة الدفع
    public function processPayment(Request $request)
    {
        $request->validate([
            'contract_id' => 'required|exists:contracts,id',
            'payment_method' => 'required', // 'paypal' or 'credit_card'
            'card_number' => 'required_if:payment_method,credit_card',
            'expiry_date' => 'required_if:payment_method,credit_card',
            'cvv' => 'required_if:payment_method,credit_card',
            // 'paypal_email' => 'required_if:payment_method,paypal',
        ]);

        $contract = Contract::find($request->contract_id);
        $serviceOrder = ServiceOrder::find($contract->service_order_id);
        $service = Service::find($serviceOrder->service_id);
        if (!$contract) {
            return response()->json(['message' => 'Contract not found!'], 404);
        }

        $totalAmount = $contract->payment_amount;

        $payment = Payment::create([
            'contract_id' => $request->contract_id,
            'amount' => $totalAmount,
            'payment_method' => $request->payment_method,
            'card_number' => $request->card_number,
            'expiry_date' => $request->expiry_date,
            'cvv' => $request->cvv,
            // 'paypal_email' => $request->paypal_email,
        ]);

        // تحديث حالة الدفع في العقد
        $contract->update(['payment_status' => 'paid']);
        $serviceOrder->update(['status'=>'active']);
        return response()->json(['message' => 'Payment successful!', 'payment' => $payment, 'contract' => $contract]);
    }
}
