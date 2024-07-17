<?php

namespace App\Http\Controllers;

use App\Models\Service;
use App\Models\ServiceOrder;
use Illuminate\Http\Request;
use Stripe\StripeClient;

class paymentController extends Controller
{
    public $stripe;
    public function __construct() {
        $this->stripe = new StripeClient(env('STRIPE_SECRET'));
    }  
    public function pay(Request $request,$serviceOrder)  {
      $s=ServiceOrder::find($serviceOrder);
      $data =Service::find($s->service_id);
      $session = $this->stripe->checkout->sessions->create([
             
                'line_items' => [[
                  'price_data' => [
                    'currency' => 'usd',
                    'product_data' => [
                      'name' =>$data->title,
                    ],
                    'unit_amount' => $data->price*100 ,
                  ],
                  'quantity' => $s->amount,
                ]],
                'mode' => 'payment',
                'success_url' => 'http://localhost:8000/success',
                'cancel_url' => 'http://localhost:8000/cancel',
              ]);        
              return $session->url; 
      // return response()->json([$s,$data]); 
            // return redirect($session->url);
        }
    
}
 