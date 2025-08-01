import 'package:dartz/dartz.dart';
import 'package:gharko_doctor/app/sharedPref/token_shared_pref.dart';
import 'package:gharko_doctor/core/error/failure.dart';

class TokenHelper {
  final TokenSharedPrefs tokenPrefs;

  TokenHelper(this.tokenPrefs);

  Future<String> readToken() async {
    final result = await tokenPrefs.getToken();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (token) => token ?? '',
    );
  }
}
