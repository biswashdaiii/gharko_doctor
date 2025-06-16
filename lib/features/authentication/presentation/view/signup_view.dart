import 'package:flutter/material.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Create Account',
          style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                 color: Colors.teal,
                ),
          )
        ],
      ),
    );
  }
}