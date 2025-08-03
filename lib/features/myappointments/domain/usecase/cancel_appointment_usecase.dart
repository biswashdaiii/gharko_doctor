// domain/usecase/cancel_user_appointment_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:gharko_doctor/app/sharedPref/token_shared_pref.dart';
import 'package:gharko_doctor/app/usecase/usecase.dart';
import 'package:gharko_doctor/core/error/failure.dart';
import 'package:gharko_doctor/features/myappointments/domain/repository/myappointment_Irepository.dart';

class CancelUserAppointmentUseCase implements UsecaseWithParams<void, String> {
  final IMyAppointmentRepository _repository;
  final TokenSharedPrefs _tokenSharedPrefs;

  CancelUserAppointmentUseCase({
    required IMyAppointmentRepository repository,
    required TokenSharedPrefs tokenSharedPrefs,
  })  : _repository = repository,
        _tokenSharedPrefs = tokenSharedPrefs;

  @override
  Future<Either<Failure, void>> call(String appointmentId) async {
    final tokenResult = await _tokenSharedPrefs.getToken();

    if (tokenResult.isLeft()) {
      return Left(tokenResult.swap().getOrElse(
          () => RemoteDatabaseFailure(message: "Token fetch failed")));
    }

    final token = tokenResult.getOrElse(() => null);
    if (token == null) {
      return Left(RemoteDatabaseFailure(message: "User not logged in"));
    }

    return await _repository.cancelAppointment(appointmentId, token);
  }
}
