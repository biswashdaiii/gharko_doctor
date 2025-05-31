import 'package:flutter/material.dart';

class Doctor extends StatefulWidget {
  const Doctor({super.key});

  @override
  State<Doctor> createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text("doctor page hai",
      style: TextStyle(
        fontSize: 25,
        backgroundColor: Colors.yellow
      ),
      ),
    );
  }
}