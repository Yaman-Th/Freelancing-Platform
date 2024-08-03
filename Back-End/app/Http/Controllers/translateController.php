<?php

namespace App\Http\Controllers;

use App\Models\Post;
use App\Models\Service;
use Stichoza\GoogleTranslate\GoogleTranslate;
use Illuminate\Http\Request;

class translateController extends Controller
{
    public function getTranslatedData(Request $request,$type,$lang,$id)
    {
        if($type==='post'){
        $thepost=Post::find($id);
        $content = $thepost->description;
    }
        else if($type==='service'){
        $thepost=Service::find($id);
        $content = $thepost->description;
}
        $targetLang = $request->input('targetLang',$lang); 

        $tr = new GoogleTranslate();
        $tr->setSource('auto');
        $tr->setTarget($targetLang);

        $translatedContent = $tr->translate($content);

        return response()->json(['translatedContent' => $translatedContent]);
    }
}
