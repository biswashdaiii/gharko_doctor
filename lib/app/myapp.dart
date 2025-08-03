import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/sigin_view_model/login_view_model.dart';
import 'package:gharko_doctor/features/booking/domain/usecase/book_appointment_usecase.dart';
import 'package:gharko_doctor/app/service_locator/service_locator.dart';
import 'package:gharko_doctor/features/myappointments/domain/usecase/cancel_appointment_usecase.dart';
import 'package:gharko_doctor/features/myappointments/domain/usecase/get_appointment_usecase.dart';
import 'package:gharko_doctor/features/myappointments/presentation/view_model/myappointments_bloc.dart';
import 'package:gharko_doctor/features/profile/presentation/viewmodel/profile_bloc.dart';
import 'package:gharko_doctor/features/splash/presentation/view/splash_screen.dart';
import 'package:gharko_doctor/features/splash/presentation/view_model/splash_view_model.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<SplashViewModel>(
          create: (_) => serviceLocator<SplashViewModel>(),
        ),
        BlocProvider<LoginViewModel>(
          create: (_) => serviceLocator<LoginViewModel>(),
        ),
        BlocProvider<ProfileBloc>(
          // ✅ Add this
          create: (_) => serviceLocator<ProfileBloc>(),
        ),
        Provider<BookAppointmentUseCase>(
          create: (_) => serviceLocator<BookAppointmentUseCase>(),
        ),
       
        Provider<GetUserAppointmentsUseCase>(
          create: (_) => serviceLocator<GetUserAppointmentsUseCase>(),
        ),
        Provider<CancelUserAppointmentUseCase>(
          create: (_) => serviceLocator<CancelUserAppointmentUseCase>(),
        ),
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
