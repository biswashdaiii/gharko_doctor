import 'package:gharko_doctor/features/booking/data/model/appointment_model.dart';

abstract interface class IAppointmentRemoteDataSource {
  /// Fetches appointments for a user or doctor based on the provided token and optional filters.
  Future<List<AppointmentModel>> fetchAppointments(String token, {String? userId, String? docId});

  /// Books a new appointment.
  Future<void> bookAppointment(AppointmentModel appointment, String token);

  /// Cancels an existing appointment by ID.
  Future<void> cancelAppointment(String appointmentId, String token);
}
