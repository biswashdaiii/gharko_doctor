import 'package:dartz/dartz.dart';
import 'package:gharko_doctor/core/error/failure.dart';
import 'package:gharko_doctor/features/booking/domain/entities/appointment_entity.dart';

abstract interface class IAppointmentRepository {
  /// Get appointments for a user (or optionally doctor)
  Future<Either<Failure, List<AppointmentEntity>>> getAppointments(String token, {String? userId, String? docId});

  /// Book a new appointment
  Future<Either<Failure, void>> bookAppointment(AppointmentEntity appointment, String token);

  /// Cancel an existing appointment
  Future<Either<Failure, void>> cancelAppointment(String id, String token);
}
