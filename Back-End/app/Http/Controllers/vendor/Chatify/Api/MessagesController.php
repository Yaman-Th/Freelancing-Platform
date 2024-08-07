<?php

namespace App\Http\Controllers\vendor\Chatify\Api;

use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Response;
use App\Models\ChMessage as Message;
use App\Models\ChFavorite as Favorite;
use Chatify\Facades\ChatifyMessenger as Chatify;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Illuminate\Http\JsonResponse;
use App\Models\ChChannel as Channel;
use Illuminate\Support\Facades\Request as FacadesRequest;
use Illuminate\Support\Facades\Log;


class MessagesController extends Controller
{
    protected $perPage = 30;

    /**
     * Authinticate the connection for pusher
     *
     * @param Request $request
     * @return void
     */
    public function pusherAuth(Request $request)
    {
        $authData = Chatify::pusherAuth(
            $request->user(),
            Auth::user(),
            $request['channel_name'],
            $request['socket_id']
        );
    
        return response()->json($authData, 200);
    }
    
    public function index($channel_id = null)
    {
        $messenger_color = Auth::user()->messenger_color;

        if (!Auth::user()->channel_id) {
            Chatify::createPersonalChannel();
        }

        $channel = $channel_id ? Channel::where('id', $channel_id)->first() : null;
        $response = [
            'channel_id' => $channel_id ?? 0,
            'channel' => $channel,
            'messengerColor' => $messenger_color ? $messenger_color : Chatify::getFallbackColor(),
            'dark_mode' => Auth::user()->dark_mode < 1 ? 'light' : 'dark',
        ];

        return Response::json($response);
    }

    public function idFetchData(Request $request)
    {
        $fetch = null;
        $channel_avatar = null;

        $favorite = Chatify::inFavorite($request['channel_id']);
        $channel = Channel::find($request['channel_id']);

        if (!$channel) {
            return Response::json([
                'message' => "This chat channel doesn't exist!"
            ], 404); // إضافة كود الحالة 404
        }

        $allow_loading = $channel->owner_id === Auth::user()->id
            || in_array(Auth::user()->id, $channel->users()->pluck('id')->all());
        if (!$allow_loading) {
            return Response::json([
                'message' => "You haven't joined this chat channel!"
            ], 403); // إضافة كود الحالة 403
        }

        // تحقق مما إذا كانت هذه القناة مجموعة
        if (isset($channel->owner_id)) {
            $fetch = $channel;
            $channel_avatar = Chatify::getChannelWithAvatar($channel)->avatar;
        } else {
            $fetch = Chatify::getUserInOneChannel($request['channel_id']);
            if ($fetch) {
                $channel_avatar = Chatify::getUserWithAvatar($fetch)->avatar;
            }
        }

        $infoHtml = view('Chatify::layouts.info', [
            'channel' => $channel,
        ])->render();

        return Response::json([
            'infoHtml' => $infoHtml,
            'favorite' => $favorite,
            'fetch' => $fetch ?? null,
            'channel_avatar' => $channel_avatar ?? null,
        ]);
    }
    public function send(Request $request)
    {
        // التحقق من تسجيل الدخول
        if (!Auth::check()) {
            return response()->json([
                'status' => 401,
                'error' => 'User not authenticated',
            ]);
        }

        $userId = Auth::user()->id;

        // تعريف المتغيرات الافتراضية
        $error = (object)[
            'status' => 0,
            'message' => null
        ];
        $attachment = null;
        $attachment_title = null;

        // التحقق من وجود ملف مرفق
        if ($request->hasFile('file')) {
            // الامتدادات المسموح بها
            $allowed_images = Chatify::getAllowedImages();
            $allowed_files  = Chatify::getAllowedFiles();
            $allowed        = array_merge($allowed_images, $allowed_files);

            $file = $request->file('file');
            // التحقق من حجم الملف
            if ($file->getSize() < Chatify::getMaxUploadSize()) {
                if (in_array(strtolower($file->extension()), $allowed)) {
                    // الحصول على اسم المرفق
                    $attachment_title = $file->getClientOriginalName();
                    // رفع المرفق وتخزين الاسم الجديد
                    $attachment = Str::uuid() . "." . $file->extension();
                    $file->storeAs(config('chatify.attachments.folder'), $attachment, config('chatify.storage_disk_name'));
                } else {
                    $error->status = 1;
                    $error->message = "امتداد الملف غير مسموح!";
                }
            } else {
                $error->status = 1;
                $error->message = "حجم الملف الذي تحاول رفعه كبير جدًا!";
            }
        }

        if (!$error->status) {
            // معالجة الرسالة
            $lastMess = Message::where('to_channel_id', $request['channel_id'])->latest()->first();
            $lastMessFromId = $lastMess ? $lastMess->from_id : null;

            $message = Chatify::newMessage([
                'from_id' => $userId,
                'to_channel_id' => $request['channel_id'],
                'body' => htmlentities(trim($request['message']), ENT_QUOTES, 'UTF-8'),
                'attachment' => ($attachment) ? json_encode((object)[
                    'new_name' => $attachment,
                    'old_name' => htmlentities(trim($attachment_title), ENT_QUOTES, 'UTF-8'),
                ]) : null,
            ]);

            // تحميل معلومات المستخدم
            $message->user_avatar = Auth::user()->avatar;
            $message->user_name = Auth::user()->name;
            $message->user_email = Auth::user()->email;

            $messageData = Chatify::parseMessage($message, null, $lastMessFromId !== $userId);

            // إرسال رسالة الدفع (Pusher)
            Chatify::push("private-chatify." . $request['channel_id'], 'messaging', [
                'from_id' => $userId,
                'to_channel_id' => $request['channel_id'],
                'message' => Chatify::messageCard($messageData, true)
            ]);
        }

        // إرسال الرد
        return response()->json([
            'status' => $error->status ? 400 : 200, // 400 في حالة الخطأ، 200 في حالة النجاح
            'error' => $error->status ? $error->message : null,
            'message' => $error->status ? null : $request->message,
            'tempID' => $request['temporaryMsgId'],
        ]);
    }

    public function fetch(Request $request)
    {
        $query = Chatify::fetchMessagesQuery($request['id'])->latest();
        $messages = $query->paginate($request->per_page ?? $this->perPage);
        $totalMessages = $messages->total();
        $lastPage = $messages->lastPage();
        $response = [
            'total' => $totalMessages,
            'last_page' => $lastPage,
            'last_message_id' => collect($messages->items())->last()->id ?? null,
            'messages' => [],
        ];

        // إذا لم يكن هناك رسائل حتى الآن.
        if ($totalMessages < 1) {
            $response['messages'] = '<p class="message-hint center-el"><span>Say \'hi\' and start messaging</span></p>';
            return Response::json($response);
        }
        if (count($messages->items()) < 1) {
            $response['messages'] = [];
            return Response::json($response);
        }

        foreach ($messages->reverse() as $message) {
            $response['messages'][] = [
                'id' => $message->id,
                'from_id' => $message->from_id,
                'to_id' => $message->to_id,
                'body' => $message->body,
                'created_at' => $message->created_at->toIso8601String(),
                'updated_at' => $message->updated_at->toIso8601String(),
                'seen' => $message->seen,
            ];
        }

        return Response::json($response);
    }

    public function seen(Request $request)
    {
        // التأكد من صحة مدخلات الطلب
        $channelId = $request->input('channel_id');
        if (!$channelId) {
            return Response::json([
                'status' => false,
                'message' => 'Channel ID is required',
            ], 400);
        }

        // تحديث حالة الرسائل إلى "مرئية" للقناة المحددة
        try {
            $seen = Chatify::makeSeen($channelId);
        } catch (\Exception $e) {
            return Response::json([
                'status' => false,
                'message' => $e->getMessage(),
            ], 500);
        }

        // إرسال الرد
        return Response::json([
            'status' => $seen,
        ], 200);
    }
    public function getChannelId(Request $request)
    {
        $user_id = $request->input('user_id');
        $res = Chatify::getOrCreateChannel($user_id);

        // send the response
        return Response::json($res, 200);
    }

    public function getContacts(Request $request)
    {
        $query = Channel::join('ch_messages', 'ch_channels.id', '=', 'ch_messages.to_channel_id')
            ->join('ch_channel_user', 'ch_channels.id', '=', 'ch_channel_user.channel_id')
            ->where('ch_channel_user.user_id', '=', Auth::user()->id)
            ->select('ch_channels.*', DB::raw('MAX(ch_messages.created_at) as messaged_at'))
            ->groupBy('ch_channels.id')
            ->orderBy('messaged_at', 'desc')
            ->paginate($request->per_page ?? $this->perPage);

        $channelsList = $query->items();

        $contacts = [];

        if (count($channelsList) > 0) {
            foreach ($channelsList as $channel) {
                $contacts[] = [
                    'channel_id' => $channel->id,
                    'name' => $channel->name,
                    'created_at' => $channel->created_at->toIso8601String(),
                    'updated_at' => $channel->updated_at->toIso8601String(),
                    'last_message_at' => $channel->messaged_at,
                    // يمكنك إضافة المزيد من التفاصيل هنا بناءً على هيكل البيانات الخاص بك
                ];
            }
        } else {
            $contacts = [];
        }

        return Response::json([
            'contacts' => $contacts,
            'total' => $query->total() ?? 0,
            'last_page' => $query->lastPage() ?? 1,
        ], 200);
    }
    public function createGroupChat(Request $request)
{
    $msg = null;
    $error = $success = 0;

    // تحويل قائمة معرفات المستخدمين إلى مصفوفة من الأعداد الصحيحة
    $user_ids = array_map('intval', explode(',', $request->input('user_ids')));
    $user_ids[] = Auth::user()->id;

    $group_name = $request->input('group_name');

    // إنشاء القناة الجديدة
    $new_channel = new Channel();
    $new_channel->name = $group_name;
    $new_channel->owner_id = Auth::user()->id;
    $new_channel->save();
    $new_channel->users()->sync($user_ids);

    // إضافة الرسالة الأولى
    $message = Chatify::newMessage([
        'from_id' => Auth::user()->id,
        'to_channel_id' => $new_channel->id,
        'body' => Auth::user()->name . ' has created a new chat group: ' . $group_name,
        'attachment' => null,
    ]);
    $message->user_name = Auth::user()->name;
    $message->user_email = Auth::user()->email;

    $messageData = Chatify::parseMessage($message, null);
    Chatify::push("private-chatify." . $new_channel->id, 'messaging', [
        'from_id' => Auth::user()->id,
        'to_channel_id' => $new_channel->id,
        'message' => Chatify::messageCard($messageData, true)
    ]);

    // معالجة تحميل الصورة الرمزية
    if ($request->hasFile('avatar')) {
        // الامتدادات المسموح بها
        $allowed_images = Chatify::getAllowedImages();

        $file = $request->file('avatar');
        // التحقق من حجم الملف
        if ($file->getSize() < Chatify::getMaxUploadSize()) {
            if (in_array(strtolower($file->extension()), $allowed_images)) {
                $avatar = Str::uuid() . "." . $file->extension();
                $update = $new_channel->update(['avatar' => $avatar]);
                $file->storeAs(config('chatify.channel_avatar.folder'), $avatar, config('chatify.storage_disk_name'));
                $success = $update ? 1 : 0;
            } else {
                $msg = "File extension not allowed!";
                $error = 1;
            }
        } else {
            $msg = "File size you are trying to upload is too large!";
            $error = 1;
        }
    }

    // إرجاع الاستجابة
    return Response::json([
        'status' => $success ? 1 : 0,
        'error' => $error ? 1 : 0,
        'message' => $error ? $msg : 0,
        'channel' => $new_channel
    ], 200);
}

public function search(Request $request)
{
    $input = trim(filter_var($request['input'], FILTER_SANITIZE_STRING));

    // البحث في المستخدمين
    $users = User::where('id', '!=', Auth::user()->id)
        ->where('name', 'LIKE', "%{$input}%")
        ->get(); // نستخدم get() بدلاً من paginate هنا لنجلب كل النتائج

    // البحث في المجموعات
    $channels = Channel::where('name', 'LIKE', "%{$input}%")
        ->get(); // نستخدم get() بدلاً من paginate هنا لنجلب كل النتائج

    // تحويل بيانات المستخدمين لإضافة الصورة الرمزية
    $usersWithAvatars = $users->map(function ($user) {
        return array_merge($user->toArray(), Chatify::getUserWithAvatar($user)->toArray());
    });

    // إعادة البيانات كـ JSON
    return Response::json([
        'users' => $usersWithAvatars,
        'channels' => $channels,
        'total_users' => $users->count(),
        'total_channels' => $channels->count(),
    ], 200);
}









    public function setActiveStatus(Request $request)
    {
        $activeStatus = $request['status'] > 0 ? 1 : 0;
        $status = User::where('id', Auth::user()->id)->update(['active_status' => $activeStatus]);
        return Response::json([
            'status' => $status,
        ], 200);
    }
    public function download($fileName)
    {
        $path = config('chatify.attachments.folder') . '/' . $fileName;
        if (Chatify::storage()->exists($path)) {
            return response()->json([
                'file_name' => $fileName,
                'download_path' => Chatify::storage()->url($path)
            ], 200);
        } else {
            return response()->json([
                'message' => "Sorry, File does not exist in our server or may have been deleted!"
            ], 404);
        }
    }
    public function sharedPhotos(Request $request)
    {
        $images = Chatify::getSharedPhotos($request['user_id']);

        foreach ($images as $image) {
            $image = asset(config('chatify.attachments.folder') . $image);
        }
        // send the response
        return Response::json([
            'shared' => $images ?? [],
        ], 200);
    }
    public function favorite(Request $request)
    {
        $userId = $request['user_id'];
        // check action [star/unstar]
        $favoriteStatus = Chatify::inFavorite($userId) ? 0 : 1;
        Chatify::makeInFavorite($userId, $favoriteStatus);

        // send the response
        return Response::json([
            'status' => @$favoriteStatus,
        ], 200);
    }

    /**
     * Get favorites list
     *
     * @param Request $request
     * @return void
     */
    public function getFavorites(Request $request)
    {
        $favorites = Favorite::where('user_id', Auth::user()->id)->get();
        foreach ($favorites as $favorite) {
            $favorite->user = User::where('id', $favorite->favorite_id)->first();
        }
        return Response::json([
            'total' => count($favorites),
            'favorites' => $favorites ?? [],
        ], 200);
    }

    public function deleteConversation(Request $request)
    {
        // delete
        $delete = Chatify::deleteConversation($request['id']);

        // send the response
        return Response::json([
            'deleted' => $delete ? 1 : 0,
        ], 200);
    }

    public function updateSettings(Request $request)
    {
        $msg = null;
        $error = $success = 0;

        // dark mode
        if ($request['dark_mode']) {
            $request['dark_mode'] == "dark"
                ? User::where('id', Auth::user()->id)->update(['dark_mode' => 1])  // Make Dark
                : User::where('id', Auth::user()->id)->update(['dark_mode' => 0]); // Make Light
        }

        // If messenger color selected
        if ($request['messengerColor']) {
            $messenger_color = trim(filter_var($request['messengerColor']));
            User::where('id', Auth::user()->id)
                ->update(['messenger_color' => $messenger_color]);
        }
        // if there is a [file]
        if ($request->hasFile('avatar')) {
            // allowed extensions
            $allowed_images = Chatify::getAllowedImages();

            $file = $request->file('avatar');
            // check file size
            if ($file->getSize() < Chatify::getMaxUploadSize()) {
                if (in_array(strtolower($file->extension()), $allowed_images)) {
                    // delete the older one
                    if (Auth::user()->avatar != config('chatify.user_avatar.default')) {
                        $path = Chatify::getUserAvatarUrl(Auth::user()->avatar);
                        if (Chatify::storage()->exists($path)) {
                            Chatify::storage()->delete($path);
                        }
                    }
                    // upload
                    $avatar = Str::uuid() . "." . $file->extension();
                    $update = User::where('id', Auth::user()->id)->update(['avatar' => $avatar]);
                    $file->storeAs(config('chatify.user_avatar.folder'), $avatar, config('chatify.storage_disk_name'));
                    $success = $update ? 1 : 0;
                } else {
                    $msg = "File extension not allowed!";
                    $error = 1;
                }
            } else {
                $msg = "File size you are trying to upload is too large!";
                $error = 1;
            }
        }

        // send the response
        return Response::json([
            'status' => $success ? 1 : 0,
            'error' => $error ? 1 : 0,
            'message' => $error ? $msg : 0,
        ], 200);
    }
}
