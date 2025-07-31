import 'package:dartz/dartz.dart';
import 'package:gharko_doctor/app/sharedPref/token_shared_pref.dart';
import 'package:gharko_doctor/core/error/failure.dart';
import 'package:gharko_doctor/features/myappointments/data/datasource/abstractRemotedatasource.dart';
import 'package:gharko_doctor/features/myappointments/domain/entitiy/myapppointment_entity.dart';
import 'package:gharko_doctor/features/myappointments/domain/repository/myappointment_Irepository.dart';
class MyAppointmentRepositoryImpl implements IMyAppointmentRepository {
  final MyAppointmentRemoteDataSource remoteDataSource;
  final TokenSharedPrefs tokenSharedPrefs;

  MyAppointmentRepositoryImpl({
    required this.remoteDataSource,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, List<MyAppointmentEntity>>> getMyAppointments(String token) async {
    try {
      final appointments = await remoteDataSource.getMyAppointments(token);
      return Right(appointments);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: 'Failed to fetch appointments'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelAppointment(String appointmentId, String token) async {
    try {
      await remoteDataSource.cancelAppointment(token, appointmentId);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: 'Failed to cancel appointment'));
    }
  }
}
