import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/sigin_view_model/login_view_model.dart';
import 'package:lottie/lottie.dart';
import 'package:gharko_doctor/app/service_locator/service_locator.dart';
import 'package:gharko_doctor/features/authentication/presentation/view/signin_screen.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider<LoginViewModel>(
            create: (_) => serviceLocator<LoginViewModel>(),
            child: LoginScreen(),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 160,
              width: 160,
              child: Lottie.asset("assets/images/animation.json"),
            ),
            const SizedBox(height: 16),
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Gharko ',
                    style: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(
                    text: 'Doctor',
                    style: TextStyle(
                      fontSize: 44,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
