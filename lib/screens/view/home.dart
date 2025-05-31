import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          Container(
           height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
             color: const Color.fromARGB(255, 7, 221, 200),
            borderRadius: BorderRadius.circular(30)
          ),
         
          padding: const EdgeInsets.all(16.0), // Optional: for spacing
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        const Text(
          "Welcome back!",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        const SizedBox(height: 10), 
        const Text(
          "Lets find your top doctor",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        const SizedBox(height: 60),
        TextField(
          decoration: InputDecoration(
            hintText: "Search...",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            suffixIcon: Icon(Icons.search),
          ),
        ),
      ],
    ),
  ),
  const SizedBox(height: 20),
  const Text("Specialities most relevant to you",
  style: TextStyle(
    fontFamily: 'openSans',
    

  ),)
        ],


      ),)),
    );
  }
}