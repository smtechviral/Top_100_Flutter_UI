import 'package:day_challenge_100/screens/calender_ui.dart';
import 'package:day_challenge_100/screens/fitness_ui.dart';
import 'package:day_challenge_100/screens/hair_dryer_aap.dart';
import 'package:day_challenge_100/screens/spotify_ui.dart';
import 'package:day_challenge_100/screens/trevel_ui.dart';
import 'package:day_challenge_100/screens/trip_calculator.dart';
import 'package:day_challenge_100/screens/yoga_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      ),
      home: const FitnessHomePage(),
    );
  }
}