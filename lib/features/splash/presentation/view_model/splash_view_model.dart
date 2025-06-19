import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/features/authentication/presentation/view/signin_screen.dart';

class SplashViewModel extends Cubit<void>{
  SplashViewModel(): super(null);

Future<void> init(BuildContext context)async{
  await Future.delayed(const Duration(seconds: 3),()async{
    //open login page
    if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: serviceLocator<LoginViewModel>(),
              child: SigninScreen(),
            ),
          ),
        );
      }
  }  )
}

}