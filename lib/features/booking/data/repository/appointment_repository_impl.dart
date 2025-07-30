import 'package:dartz/dartz.dart';

import 'package:gharko_doctor/core/error/failure.dart';
import 'package:gharko_doctor/features/booking/data/data_source/appointment_remote_datasource.dart';
import 'package:gharko_doctor/features/booking/data/model/appointment_model.dart';
import 'package:gharko_doctor/features/booking/domain/entities/appointment_entity.dart';
import 'package:gharko_doctor/features/booking/domain/repository/appointment_repository.dart';

class AppointmentRepositoryImpl implements IAppointmentRepository {
  final AppointmentRemoteDataSourceImpl remoteDataSource;

  AppointmentRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getAppointments(String token, {String? userId, String? docId}) async {
    try {
      final appointmentModels = await remoteDataSource.fetchAppointments(token, userId: userId, docId: docId);
      final appointments = appointmentModels.map(_mapModelToEntity).toList();
      return Right(appointments);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> bookAppointment(AppointmentEntity appointment, String token) async {
    try {
      final model = _mapEntityToModel(appointment);
      await remoteDataSource.bookAppointment(model, token);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cancelAppointment(String appointmentId, String token) async {
    try {
      await remoteDataSource.cancelAppointment(appointmentId, token);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  // Helper conversions
  AppointmentEntity _mapModelToEntity(AppointmentModel model) {
    return AppointmentEntity(
      userId: model.userId,
      docId: model.docId,
      slotDate: model.slotDate,
      slotTime: model.slotTime,
      docData: model.docData,
      userData: model.userData,
      amount: model.amount,
      date: model.date,
      cancelled: model.cancelled,
      payment: model.payment,
      isCompleted: model.isCompleted,
    );
  }

  AppointmentModel _mapEntityToModel(AppointmentEntity entity) {
    return AppointmentModel(
      userId: entity.userId,
      docId: entity.docId,
      slotDate: entity.slotDate,
      slotTime: entity.slotTime,
      docData: entity.docData,
      userData: entity.userData,
      amount: entity.amount,
      date: entity.date,
      cancelled: entity.cancelled,
      payment: entity.payment,
      isCompleted: entity.isCompleted,
    );
  }
}
