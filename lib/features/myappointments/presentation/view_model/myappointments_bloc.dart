import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/features/myappointments/domain/usecase/cancel_appointment_usecase.dart';
import 'package:gharko_doctor/features/myappointments/domain/usecase/get_appointment_usecase.dart';
import 'package:gharko_doctor/features/myappointments/presentation/view_model/myappointments_event.dart';
import 'package:gharko_doctor/features/myappointments/presentation/view_model/myappointments_state.dart';
import 'package:gharko_doctor/features/myappointments/domain/entitiy/myapppointment_entity.dart';
import 'package:gharko_doctor/features/booking/domain/entities/appointment_entity.dart';

class MyAppointmentsBloc
    extends Bloc<MyAppointmentsEvent, MyAppointmentsState> {
  final GetUserAppointmentsUseCase getUserAppointmentsUseCase;
  final CancelUserAppointmentUseCase cancelUserAppointmentUseCase;

  MyAppointmentsBloc({
    required this.getUserAppointmentsUseCase,
    required this.cancelUserAppointmentUseCase,
  }) : super(const MyAppointmentsState(successMessage: '')) {
    on<LoadAppointments>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      final result = await getUserAppointmentsUseCase();

      result.fold(
        (failure) => emit(
          state.copyWith(isLoading: false, errorMessage: failure.message),
        ),
        (appointments) {
          // Convert AppointmentEntity to MyAppointmentEntity
          final myAppointments =
              appointments
                  .map(
                    (a) => MyAppointmentEntity(
                      id: a.id,
                      docData:
                          a.docData, // Make sure this field exists in AppointmentEntity
                      slotDate: a.slotDate,
                      slotTime: a.slotTime,
                      amount: a.amount,
                      cancelled: a.cancelled,
                      isCompleted: a.isCompleted,
                    ),
                  )
                  .toList();

          emit(state.copyWith(isLoading: false, appointments: myAppointments));
        },
      );
    });

    on<CancelAppointment>((event, emit) async {
  emit(state.copyWith(isLoading: true, errorMessage: null));

  final result = await cancelUserAppointmentUseCase(event.appointmentId);

  result.fold(
    (failure) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ));
    },
    (_) {
      // ✅ Optimistically update just the cancelled appointment
      final updatedAppointments = state.appointments.map((appointment) {
        if (appointment.id == event.appointmentId) {
          return MyAppointmentEntity(
            id: appointment.id,
            docData: appointment.docData,
            slotDate: appointment.slotDate,
            slotTime: appointment.slotTime,
            amount: appointment.amount,
            cancelled: true, // 🔁 mark as cancelled
            isCompleted: appointment.isCompleted,
          );
        }
        return appointment;
      }).toList();

      emit(state.copyWith(
        isLoading: false,
        appointments: updatedAppointments,
        errorMessage: null, // Clear error
        successMessage: 'Appointment cancelled successfully', // 👈 for snackbar
      ));
    },
  );
});

  }
}
