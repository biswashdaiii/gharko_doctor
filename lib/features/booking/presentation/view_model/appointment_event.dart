import 'package:equatable/equatable.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object?> get props => [];
}

class SelectDate extends AppointmentEvent {
  final DateTime date;
  const SelectDate(this.date);

  @override
  List<Object?> get props => [date];
}

class SelectTimeSlot extends AppointmentEvent {
  final String timeSlot;
  const SelectTimeSlot(this.timeSlot);

  @override
  List<Object?> get props => [timeSlot];
}

class BookAppointment extends AppointmentEvent {
  final String doctorId;
  final DateTime selectedDate;  // DateTime here, not String
  final String selectedTime;
  final double fee;
  final Map<String, dynamic> docData;
  final Map<String, dynamic> userData;
  final DateTime createdDate;   // DateTime here, not String

  const BookAppointment({
    required this.doctorId,
    required this.selectedDate,
    required this.selectedTime,
    required this.fee,
    required this.docData,
    required this.userData,
    required this.createdDate,
  });

  @override
  List<Object?> get props => [
        doctorId,
        selectedDate,
        selectedTime,
        fee,
        docData,
        userData,
        createdDate,
      ];
}
