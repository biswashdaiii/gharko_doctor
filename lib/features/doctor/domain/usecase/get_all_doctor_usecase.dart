import 'package:dartz/dartz.dart';
import 'package:gharko_doctor/core/error/failure.dart';
import 'package:gharko_doctor/features/doctor/domain/entity/doctor_entity.dart';
import 'package:gharko_doctor/features/doctor/domain/repository/doctor_repository.dart';

class GetAllDoctorsUseCase {
  final IDoctorRepository repository;

  GetAllDoctorsUseCase({required this.repository});

  Future<Either<Failure, List<DoctorEntity>>> call() async {
    return await repository.getAllDoctors();
  }
}
