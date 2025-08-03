import 'package:equatable/equatable.dart';

import 'package:gharko_doctor/features/myappointments/domain/entitiy/myapppointment_entity.dart';

class MyAppointmentsState extends Equatable {
  final List<MyAppointmentEntity> appointments;
  final bool isLoading;
  final String? errorMessage;
   final String? successMessage; 

  const MyAppointmentsState({
    this.appointments = const [],
    this.isLoading = false,
    this.errorMessage,
    required this.successMessage,
  });

  MyAppointmentsState copyWith({
    List<MyAppointmentEntity>? appointments,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
  }) {
    return MyAppointmentsState(
      appointments: appointments ?? this.appointments,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
       successMessage: successMessage,
    );
  }

  @override
  List<Object?> get props => [appointments, isLoading, errorMessage];
}
