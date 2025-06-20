import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/app/service_locator/service_locator.dart';
import 'package:gharko_doctor/features/authentication/presentation/view/signin_screen.dart';
import 'package:gharko_doctor/features/splash/presentation/view/splash_screen.dart';
import 'package:gharko_doctor/features/splash/presentation/view_model/splash_view_model.dart';

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
      home: BlocProvider.value(value: serviceLocator<SplashViewModel>(),child: SplashScreenView()), 
    );
  }
}
