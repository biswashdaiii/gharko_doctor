import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/app/service_locator/service_locator.dart';
import 'package:gharko_doctor/features/doctor/domain/usecase/get_all_doctor_usecase.dart';
import 'package:gharko_doctor/features/doctor/domain/usecase/get_doctor_byspeciality_usecase.dart';
import 'package:gharko_doctor/features/dashboardd/presentation/view/main_dashboard.dart';
import 'package:gharko_doctor/features/doctor/presentation/view_model/doctor_bloc.dart';
import 'package:gharko_doctor/features/doctor/presentation/view_model/doctor_event.dart';

class DoctorsPageWithProvider extends StatelessWidget {
  const DoctorsPageWithProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DoctorBloc(
        getAllDoctorsUseCase: serviceLocator<GetAllDoctorsUseCase>(),
        getDoctorsBySpecialityUseCase: serviceLocator<GetDoctorsBySpecialityUseCase>(),
      )..add(FetchAllDoctorsEvent()),
      child: const MainDashboard(),
    );
  }
}
