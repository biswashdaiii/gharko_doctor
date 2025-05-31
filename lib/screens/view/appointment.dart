import 'package:flutter/material.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text(
        "appointment page hai",
        style: TextStyle(
          fontSize: 25,
          backgroundColor: Colors.blue
        ),

      ),
    );
  }
}