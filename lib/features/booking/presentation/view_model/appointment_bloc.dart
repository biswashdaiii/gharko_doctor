import 'package:flutter_bloc/flutter_bloc.dart';
import 'appointment_event.dart';
import 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentBloc()
      : super(AppointmentState(
          selectedDate: DateTime.now(),
          selectedTimeSlot: '08:00 pm',
        )) {
    on<SelectDate>((event, emit) {
      emit(state.copyWith(selectedDate: event.date));
    });

    on<SelectTimeSlot>((event, emit) {
      emit(state.copyWith(selectedTimeSlot: event.timeSlot));
    });

    on<BookAppointment>((event, emit) async {
      emit(state.copyWith(isLoading: true, bookingSuccess: false, errorMessage: null));

      try {
        // Simulate booking delay
        await Future.delayed(const Duration(seconds: 2));

        // Here you call your repository/usecase to book the appointment
        // await bookingRepository.bookAppointment(...);

        emit(state.copyWith(isLoading: false, bookingSuccess: true));
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          bookingSuccess: false,
          errorMessage: 'Failed to book appointment: $e',
        ));
      }
    });
  }
}
