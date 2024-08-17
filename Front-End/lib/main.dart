import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelancing/Auth/old_client_register.dart';
import 'package:freelancing/Auth/login.dart';
import 'package:freelancing/Auth/register.dart';
import 'package:freelancing/Provider/post_provider.dart';
import 'package:freelancing/Provider/service_provider.dart';
import 'package:freelancing/Provider/team_provider.dart';
import 'package:freelancing/Screens/Post/post_screen.dart';
import 'package:freelancing/Screens/chat.dart';
import 'package:freelancing/Server/post_service.dart';
import 'package:freelancing/Server/team_service.dart';
import 'package:freelancing/Server/service_service.dart';
import 'package:freelancing/Screens/tabs.dart';
import 'package:freelancing/Screens/Team/team_management.dart';
import 'package:freelancing/Server/team_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:freelancing/chat/freelancer_chat.dart';
import 'package:freelancing/models/post.dart';
import 'package:freelancing/notification/notification.dart';
import 'Screens/Service/create_a_service.dart';
import 'firebase_options.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: const Color(0xff214269),
  background: const Color(0xffFFFFFF),
  onPrimary: const Color(0xff65EBC6),
  onSecondary: const Color(0xff6792BD),
  onTertiary: const Color(0xffC5CDCD),
  onBackground: const Color.fromARGB(255, 110, 110, 110),
  onSurface: const Color(0xff214269),
  secondary: const Color.fromARGB(255, 240, 246, 255),
  primary: Colors.black,
);
final theme = ThemeData().copyWith(
  useMaterial3: true,
  scaffoldBackgroundColor: colorScheme.background,
  colorScheme: colorScheme,
  textTheme: const TextTheme(
    titleSmall: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      fontFamily: 'RobotoCondensed',
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      fontFamily: 'RobotoCondensed',
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30,
      fontFamily: 'RobotoCondensed',
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 25,
      fontFamily: 'RobotoCondensed',
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 35,
      fontFamily: 'RobotoCondensed',
    ),
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCJ2xkBvYZ1m2RzAA-od7bkRi1sTeRFd2o',
      appId: '1:1931909055:android:f8a811d3d92b232f56f30a',
      messagingSenderId: '1931909055',
      projectId: 'flutter-notifications-d1011',
    ),
  );
  await FirebaseApi().initNotification();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, theme: theme, home:const LoginPage());
  }
}
