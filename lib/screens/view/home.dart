import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Center(child: const Text("home screen hai",style: TextStyle(fontSize: 25,backgroundColor: Colors.lightGreen),));
  }
}