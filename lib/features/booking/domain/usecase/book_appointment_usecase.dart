import 'package:dartz/dartz.dart';
import 'package:gharko_doctor/app/sharedPref/token_shared_pref.dart';
import 'package:gharko_doctor/app/usecase/usecase.dart';
import 'package:gharko_doctor/core/error/failure.dart';
import 'package:gharko_doctor/features/booking/domain/entities/appointment_entity.dart';
import 'package:gharko_doctor/features/booking/domain/repository/appointment_repository.dart';

class BookAppointmentUseCase implements UsecaseWithParams<void, AppointmentEntity> {
  final IAppointmentRepository _repository;
  final TokenSharedPrefs _tokenSharedPrefs;

  BookAppointmentUseCase({
    required IAppointmentRepository repository,
    required TokenSharedPrefs tokenSharedPrefs,
  })  : _repository = repository,
        _tokenSharedPrefs = tokenSharedPrefs;

  @override
  Future<Either<Failure, void>> call(AppointmentEntity appointment) async {
    // Fetch the stored token (authentication)
    final tokenResult = await _tokenSharedPrefs.getToken();

    // Check if fetching token failed
    if (tokenResult.isLeft()) {
      // Return failure from token fetching
      return Left(tokenResult.swap().getOrElse(() => RemoteDatabaseFailure(message: "Token fetch failed")));
    }

    // Extract token or null if not found
    final String? token = tokenResult.getOrElse(() => null);

    if (token == null) {
      return Left(RemoteDatabaseFailure(message: "User not logged in"));
    }

    // Forward the booking call to repository with valid token
    return await _repository.bookAppointment(appointment, token);
  }
}
