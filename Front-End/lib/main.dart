import 'package:flutter/material.dart';
import 'package:freelancing/DashboardScreens/freelancer_dashboard.dart';
import 'package:freelancing/Auth/client_register.dart';
import 'package:freelancing/Auth/freelancer_register.dart';
import 'package:freelancing/Auth/login.dart';
import 'package:freelancing/post_management.dart';
import 'package:freelancing/Auth/register.dart';
import 'package:freelancing/service_management.dart';
import 'package:freelancing/tabs.dart';
import 'package:freelancing/team_management.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: const Color.fromARGB(255, 33, 66, 105),
  background: const Color.fromARGB(255, 255, 255, 255),
  onPrimary: const Color.fromARGB(255, 101, 235, 198),
  onSecondary: const Color.fromARGB(255, 103, 146, 189),
  onBackground: const Color.fromARGB(255, 110, 110, 110),
  onSurface: const Color.fromARGB(255, 33, 66, 105),
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
      ));
void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home:const LoginPage(),
    );
  }
}
