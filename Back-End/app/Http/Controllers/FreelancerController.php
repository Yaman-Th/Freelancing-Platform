<?php

namespace App\Http\Controllers;

use App\Models\Skill;
use App\Http\Requests;
use App\Models\Auth\User;
use GuzzleHttp\Psr7\Message;
use Illuminate\Http\Request;
use Ramsey\Uuid\Type\Integer;
use App\Models\Auth\Freelancer;
use App\Models\Freelancer_Skill;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class FreelancerController extends Controller
{
    // to make the user Freelancer
    public function updateProfile(Request $request, Freelancer $freelancer)
{
    try {
        $request->validate([
            'personal_image' => 'sometimes|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            'personal_overview' => 'sometimes|string',
        ]);

        if ($request->hasFile('personal_image')) {
            $personal_image = $request->file('personal_image')->store('personal_images');
            // تحديث حقل الصورة في الفريلانسر
            $freelancer->update([
                'personal_image' => $personal_image,
                'personal_overview' => $request->input('personal_overview'),
            ]);
        } else {
            $freelancer->update([
                'personal_overview' => $request->personal_overview
            ]);
        }
    } catch (ValidationException $exception) {
        return response()->json([
            'message' => 'Validation Error',
            'errors' => $exception->errors()
        ], 422);
    }

    return response()->json(['message' => 'Update Successfully']);
}

    /**
     * profile
     */
    // all info
    public function profile(string $id)
    //    SELECT * FROM freelancers f JOIN users u on u.id=f.id WHERE f.id=3
    {
        $freelancerinfo = DB::table('freelancers')
            ->join('users', 'users.id', '=', 'freelancers.user_id') // Assuming freelancers table has user_id column
            ->select('freelancers.*', 'users.*')
            ->where('freelancers.id', $id)
            ->first();
        // $Skill
        return response()->json($freelancerinfo);
    }

}

