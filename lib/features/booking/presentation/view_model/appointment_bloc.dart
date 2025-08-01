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
      : super(
          AppointmentState(
            selectedDate: DateTime.now().add(const Duration(days: 1)),
            selectedTimeSlot: '10:00 AM',
            isLoading: false,
            bookingSuccess: false,
            errorMessage: null,
          ),
        ) {
    // Handle date selection event
    on<SelectDate>((event, emit) {
      emit(state.copyWith(selectedDate: event.date));
    });

    // Handle time slot selection event
    on<SelectTimeSlot>((event, emit) {
      emit(state.copyWith(selectedTimeSlot: event.timeSlot));
    });

    // Handle booking event
    on<BookAppointment>((event, emit) async {
      emit(state.copyWith(isLoading: true, bookingSuccess: false, errorMessage: null));

      try {
        final appointment = AppointmentEntity(
          userId: null, // Assume backend handles user from token
          docId: event.doctorId,
          slotDate: event.selectedDate.toIso8601String().split('T').first, // yyyy-MM-dd
          slotTime: event.selectedTime,
          docData: event.docData,
          userData: event.userData ?? {}, // Ensure not null
          amount: event.fee.toDouble(),
          date: DateTime.now().toIso8601String(), // Current date/time as ISO string
          cancelled: false,
          isCompleted: false,
          payment: null,
        );

        // Debug logs to trace appointment data before sending
        print('Booking appointment with:');
        print('docId: ${appointment.docId}');
        print('slotDate: ${appointment.slotDate}');
        print('slotTime: ${appointment.slotTime}');
        print('docData: ${appointment.docData}');
        print('userData: ${appointment.userData}');
        print('amount: ${appointment.amount}');
        print('date: ${appointment.date}');

        // Simple validation to catch missing data early
        if (appointment.docId.isEmpty) throw Exception('Doctor ID is missing!');
        if (appointment.slotDate.isEmpty) throw Exception('Slot Date is missing!');
        if (appointment.slotTime.isEmpty) throw Exception('Slot Time is missing!');
        if (appointment.amount <= 0) throw Exception('Fee amount is invalid!');

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
