import 'package:flutter/material.dart';
import 'package:gharko_doctor/screens/signin_screen.dart';
import 'package:gharko_doctor/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gharko Doctor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const SplashScreenView(), // Start from signin screen
    );
  }
}
