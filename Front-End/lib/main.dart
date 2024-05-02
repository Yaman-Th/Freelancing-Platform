import 'package:flutter/material.dart';
import 'package:freelancing/Login.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 197, 205, 205),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);
Color backGroundColor =const Color.fromARGB(255, 255, 255, 255);
Color color1 = const Color.fromRGBO(33, 66, 105, 1);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      theme: theme,
      home: LoginPage(),
    );
  }
}
