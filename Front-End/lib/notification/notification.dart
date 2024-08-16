import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  await showNotification(message);
}

Future<void> showNotification(RemoteMessage message) async {
  final localNotification = FlutterLocalNotificationsPlugin();

  final notification = message.notification;
  if (notification == null) return;
  await localNotification.show(
    notification.hashCode,
    notification.title,
    notification.body,
    NotificationDetails(
      android: AndroidNotificationDetails(
        androidChannel.id,
        androidChannel.name,
        channelDescription: androidChannel.description,
        icon: '@drawable/flutter_logo',
        importance: Importance.max,
      ),
    ),
    payload: jsonEncode(message.toMap()),
  );
}

Future<String> _downloadAndSaveImage(String url, String fileName) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/$fileName.jpg';
  final response = await http.get(Uri.parse(url));
  final file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}

const androidChannel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications',
  importance: Importance.max,
);

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;
  final localNotification = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    try {
      await firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      firebaseMessaging.subscribeToTopic('free_lancing_topic');
      String? fcmToken = await firebaseMessaging.getToken();
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        showNotification(message);
      });

      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

      var initializationSettingsAndroid =
          const AndroidInitializationSettings('@drawable/flutter_logo');
      var initializationSettingsIOS = const DarwinInitializationSettings();
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      await localNotification.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (details) {},
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();

      print('The fcm token is => $fcmToken');
      prefs.setString('fcm_token', fcmToken.toString());
      print('.................');
      print(prefs.get('fcm_token'));
    } catch (e) {
      print(e);
    }
  }
}
