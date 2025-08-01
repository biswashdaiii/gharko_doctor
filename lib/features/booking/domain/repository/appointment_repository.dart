import 'package:dartz/dartz.dart';
import 'package:gharko_doctor/core/error/failure.dart';
import '../entities/appointment_entity.dart';

abstract interface class IAppointmentRepository {
  Future<Either<Failure, List<AppointmentEntity>>> getAppointments(
    String token, {
    String? userId,
    String? docId,
  });

  Future<Either<Failure, void>> bookAppointment(
    AppointmentEntity appointment,
    String token,
  );

  Future<Either<Failure, void>> cancelAppointment(
    String id,
    String token,
  );
}
