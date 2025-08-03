import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/app/service_locator/service_locator.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/sigin_view_model/login_view_model.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/register_view_model.dart';
import 'package:gharko_doctor/features/splash/presentation/view/splash_screen.dart';
import 'package:gharko_doctor/features/splash/presentation/view_model/splash_view_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashViewModel>(
          create: (_) => serviceLocator<SplashViewModel>(),
        ),
        BlocProvider<LoginViewModel>(
          create: (_) => serviceLocator<LoginViewModel>(),
        ),
        
        // Add other providers here if needed
      ],
      child: MaterialApp(
        title: 'Gharko Doctor',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),
        home: const SplashScreenView(),
      ),
    );
  }
}

