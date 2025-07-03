import 'package:dartz/dartz.dart';
import 'package:gharko_doctor/core/error/failure.dart';
import 'package:gharko_doctor/features/doctor/domain/entity/doctor_entity.dart';

abstract interface class IDoctorRepository {
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors();

  Future<Either<Failure, List<DoctorEntity>>> getDoctorsBySpeciality(String speciality);
}
