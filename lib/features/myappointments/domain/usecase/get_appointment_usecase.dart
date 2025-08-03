// domain/usecase/get_user_appointments_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:gharko_doctor/app/sharedPref/token_shared_pref.dart';
import 'package:gharko_doctor/app/usecase/usecase.dart';
import 'package:gharko_doctor/core/error/failure.dart';
import 'package:gharko_doctor/features/myappointments/domain/entitiy/myapppointment_entity.dart';
import 'package:gharko_doctor/features/myappointments/domain/repository/myappointment_Irepository.dart';


class GetUserAppointmentsUseCase implements UsecaseWithoutParams<List<MyAppointmentEntity>> {
  final IMyAppointmentRepository _repository;
  final TokenSharedPrefs _tokenSharedPrefs;

  GetUserAppointmentsUseCase({
    required IMyAppointmentRepository repository,
    required TokenSharedPrefs tokenSharedPrefs,
  })  : _repository = repository,
        _tokenSharedPrefs = tokenSharedPrefs;

  @override
  Future<Either<Failure, List<MyAppointmentEntity>>> call() async {
    final tokenResult = await _tokenSharedPrefs.getToken();

    if (tokenResult.isLeft()) {
      return Left(tokenResult.swap().getOrElse(
          () => RemoteDatabaseFailure(message: "Token fetch failed")));
    }

    final token = tokenResult.getOrElse(() => null);
    if (token == null) {
      return Left(RemoteDatabaseFailure(message: "User not logged in"));
    }

    return await _repository.getMyAppointments(token);
  }
}
