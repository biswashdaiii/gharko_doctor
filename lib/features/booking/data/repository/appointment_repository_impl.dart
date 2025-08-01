import 'package:dartz/dartz.dart';
import 'package:gharko_doctor/core/error/failure.dart';
import '../data_source/appointment_remote_datasource.dart';
import '../model/appointment_model.dart';
import '../../domain/entities/appointment_entity.dart';
import '../../domain/repository/appointment_repository.dart';

class AppointmentRepositoryImpl implements IAppointmentRepository {
  final IAppointmentRemoteDataSource remoteDataSource;

  AppointmentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getAppointments(
    String token, {
    String? userId,
    String? docId,
  }) async {
    try {
      final models = await remoteDataSource.fetchAppointments(token, userId: userId, docId: docId);
      final entities = models.map(_mapModelToEntity).toList();
      return Right(entities);
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

  // ✅ Convert Model to Entity
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
      createdDate: model.createdDate, // ✅ Added
    );
  }

  // ✅ Convert Entity to Model
  AppointmentModel _mapEntityToModel(AppointmentEntity entity) {
    return AppointmentModel(
      userId: entity.userId ?? '',
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
      createdDate: entity.createdDate, // ✅ Added
    );
  }
}
