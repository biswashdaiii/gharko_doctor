import 'package:equatable/equatable.dart';

abstract class MyAppointmentsEvent extends Equatable {
  const MyAppointmentsEvent();

  @override
  List<Object?> get props => [];
}

class LoadAppointments extends MyAppointmentsEvent {}

class CancelAppointment extends MyAppointmentsEvent {
  final String appointmentId;

  const CancelAppointment(this.appointmentId);

  @override
  List<Object?> get props => [appointmentId];
}
