import 'package:dartz/dartz.dart';
import 'package:gharko_doctor/core/error/failure.dart';
import 'package:gharko_doctor/features/myappointments/domain/entitiy/myapppointment_entity.dart';

abstract class IMyAppointmentRepository {
  Future<Either<Failure, List<MyAppointmentEntity>>> getMyAppointments(String token);
  Future<Either<Failure, void>> cancelAppointment(String appointmentId, String token);
}
