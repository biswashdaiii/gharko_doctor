import 'package:dartz/dartz.dart';
import 'package:gharko_doctor/core/error/failure.dart';
import 'package:gharko_doctor/features/dashboard/data/data_source/doctor_remote_datasource.dart';
import 'package:gharko_doctor/features/dashboard/domain/entity/doctor_entity.dart';
import 'package:gharko_doctor/features/dashboard/domain/repository/doctor_repository.dart';

class DoctorRemoteRepository implements IDoctorRepository {
  final DoctorRemoteDataSource _doctorRemoteDatasource;

  DoctorRemoteRepository({
    required DoctorRemoteDataSource doctorRemoteDatasource,
  }) : _doctorRemoteDatasource = doctorRemoteDatasource;

  @override
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors() async {
    try {
      final doctors = await _doctorRemoteDatasource.getAllDoctors();
      return Right(doctors);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DoctorEntity>>> getDoctorsBySpeciality(String speciality) async {
    try {
      final doctors = await _doctorRemoteDatasource.getDoctorsBySpeciality(speciality);
      return Right(doctors);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }
}
