
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:gharko_doctor/features/authentication/presentation/view/signin_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 160,
            width: 160,
            child:Lottie.asset("assets/images/animation.json"),
          ),
          const SizedBox(height: 16),
          RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 44, color: Colors.black),
              children: [
                TextSpan(
                  text: 'Gharko ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue ),
                ),
                TextSpan(
                  text: 'Doctor',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ],
      ),
      nextScreen: const SigninScreen(),
      splashIconSize: 250,
      backgroundColor: Colors.white,
    );
  }
}