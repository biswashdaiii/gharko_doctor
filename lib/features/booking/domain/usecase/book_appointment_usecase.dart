import 'package:dartz/dartz.dart';
import 'package:gharko_doctor/app/sharedPref/token_shared_pref.dart';
import 'package:gharko_doctor/core/error/failure.dart';
import '../entities/appointment_entity.dart';
import '../repository/appointment_repository.dart';

class BookAppointmentUseCase {
  final IAppointmentRepository _repository;
  final TokenSharedPrefs _tokenSharedPrefs;

  BookAppointmentUseCase({
    required IAppointmentRepository repository,
    required TokenSharedPrefs tokenSharedPrefs,
  })  : _repository = repository,
        _tokenSharedPrefs = tokenSharedPrefs;

  Future<Either<Failure, void>> call(AppointmentEntity appointment) async {
    final tokenResult = await _tokenSharedPrefs.getToken();

    return await tokenResult.fold(
      (failure) => Left(failure),
      (token) {
        if (token == null) {
          return Future.value(
            Left(RemoteDatabaseFailure(message: "User not logged in")),
          );
        }
        return _repository.bookAppointment(appointment, token);
      },
    );
  }
}
