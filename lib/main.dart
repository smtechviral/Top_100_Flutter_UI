
import 'package:day_challenge_100/screens/flare_login.dart';
import 'package:day_challenge_100/screens/glass_login_ui.dart';
import 'package:day_challenge_100/screens/my_tasks_screen.dart';
import 'package:day_challenge_100/screens/smart_home_ui.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DiscountTour',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Poppins',
      ),
      home:  GlassLoginScreen(),
    );
  }
}