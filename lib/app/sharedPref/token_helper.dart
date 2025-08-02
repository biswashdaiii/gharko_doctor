import 'package:dartz/dartz.dart';
import 'package:gharko_doctor/app/sharedPref/token_shared_pref.dart';
import 'package:gharko_doctor/core/error/failure.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenHelper {
  final TokenSharedPrefs tokenPrefs;

  TokenHelper(this.tokenPrefs);

  /// Reads the saved token from shared preferences
  Future<String> readToken() async {
    final result = await tokenPrefs.getToken();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (token) => token ?? '',
    );
  }

  /// Decode JWT token and extract logged-in user ID
  /// Returns null if token is empty or userId not found
  Future<String?> getLoggedInUserId() async {
    final token = await readToken();
    if (token.isEmpty) return null;

    final decoded = JwtDecoder.decode(token);

    // Adjust the key to your backend token payload field for user id
    return decoded['userId'] as String?;
  }
}
