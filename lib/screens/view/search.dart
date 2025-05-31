import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text("Search page hai",
      style: TextStyle(
        fontSize: 25,
        backgroundColor: Colors.red
      ),
      ),
    );
  }
}