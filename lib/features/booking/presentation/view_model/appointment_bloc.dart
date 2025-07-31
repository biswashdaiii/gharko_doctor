import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/core/error/failure.dart';
import 'appointment_event.dart';
import 'appointment_state.dart';
import 'package:dartz/dartz.dart';
import 'package:gharko_doctor/features/booking/domain/entities/appointment_entity.dart';
import 'package:gharko_doctor/features/booking/domain/usecase/book_appointment_usecase.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final BookAppointmentUseCase bookAppointmentUseCase;

  AppointmentBloc({required this.bookAppointmentUseCase})
      : super(AppointmentState(
          selectedDate: DateTime.now(),
          selectedTimeSlot: '08:00 pm',
          isLoading: false,
          bookingSuccess: false,
          errorMessage: null,
        )) {
    // Handle date selection event
    on<SelectDate>((event, emit) {
      emit(state.copyWith(selectedDate: event.date));
    });

    // Handle time slot selection event
    on<SelectTimeSlot>((event, emit) {
      emit(state.copyWith(selectedTimeSlot: event.timeSlot));
    });

    // Handle appointment booking event
    on<BookAppointment>((event, emit) async {
      emit(state.copyWith(isLoading: true, bookingSuccess: false, errorMessage: null));

      try {
        final appointment = AppointmentEntity(
          userId: null, // Handled on backend based on token/session
          docId: event.doctorId,
          slotDate: event.selectedDate.toIso8601String().split('T').first,
          slotTime: event.selectedTime,
          docData: event.docData,
          amount: event.fee,
          date: DateTime.now(),
          cancelled: false,
          isCompleted: false,
          payment: null,
        );

        print("Booking appointment: $appointment");

        final Either<Failure, void> result = await bookAppointmentUseCase(appointment);

        result.fold(
          (failure) {
            emit(state.copyWith(
              isLoading: false,
              bookingSuccess: false,
              errorMessage: failure.message ?? "Booking failed",
            ));
          },
          (_) {
            emit(state.copyWith(isLoading: false, bookingSuccess: true));
          },
        );
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
