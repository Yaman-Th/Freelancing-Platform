import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelancing/Auth/login.dart';
import 'package:freelancing/Provider/post_provider.dart';
import 'package:freelancing/Provider/service_provider.dart';
import 'package:freelancing/Provider/team_provider.dart';
import 'package:freelancing/Server/post_service.dart';
import 'package:freelancing/Server/team_service.dart';
import 'package:freelancing/Server/service_service.dart';
import 'package:freelancing/tabs.dart';
import 'package:freelancing/team_management.dart';
import 'package:freelancing/Server/team_service.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: const Color(0xff214269),
  background: const Color(0xffFFFFFF),
  onPrimary: const Color(0xff65EBC6),
  onSecondary: const Color(0xff6792BD),
  onBackground: const Color.fromARGB(255, 110, 110, 110),
  onSurface: const Color.fromARGB(255, 33, 66, 105),
  secondary: const Color.fromARGB(255,240, 246, 255),
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

void main() {
  runApp(
   const  ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home:const TabsScreen());
  }
}
