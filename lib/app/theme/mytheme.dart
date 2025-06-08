
import 'package:flutter/material.dart';

ThemeData getApplicationTheme(){
  return ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color.fromARGB(255, 246, 245, 241),
        fontFamily: "openSans"

      );
}