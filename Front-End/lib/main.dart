import 'package:flutter/material.dart';
import 'package:freelancing/DashboardScreens/freelancer_dashboard.dart';
import 'package:freelancing/Login.dart';
import 'package:google_fonts/google_fonts.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: const Color.fromARGB(255, 33, 66, 105),
  background: const Color.fromARGB(255, 255, 255, 255),
  onPrimary: const Color.fromARGB(255, 101, 235, 198),
  onSecondary: const Color.fromARGB(255, 103, 146, 189),
  onBackground: const Color.fromARGB(255, 197, 205, 205),
  onSurface:  const Color.fromARGB(255, 33, 66, 105),
  primary: Colors.black,
  
);
final theme = ThemeData().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: colorScheme.background,
    colorScheme: colorScheme,
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      titleSmall: GoogleFonts.lato(
        fontWeight: FontWeight.bold,
         fontSize:16
      ),
      titleMedium: GoogleFonts.lato(
        fontWeight: FontWeight.bold,
        fontSize:20
      ),
      titleLarge: GoogleFonts.lato(
        fontWeight: FontWeight.bold,
        fontSize:30
      ),
      bodyMedium: GoogleFonts.lato(
        fontWeight: FontWeight.bold,
        fontSize:25
      
    )));
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
      home:const FreelancerDashboard(),
    );
  }
}
