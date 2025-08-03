import 'package:dartz/dartz.dart';
import 'package:gharko_doctor/app/sharedPref/token_shared_pref.dart';
import 'package:gharko_doctor/core/error/failure.dart';

class AuthService {
  final TokenSharedPrefs tokenPrefs;

  AuthService({required this.tokenPrefs});

  /// Logs out the user by clearing the saved token in shared preferences
  Future<Either<Failure, void>> logout() async {
    return await tokenPrefs.clearToken();
  }
}
