import 'package:gharko_doctor/features/authentication/domain/entities/user_entity.dart';

abstract interface class IUserDataSource {
  Future<void> registerUser(UserEntity user);
  Future<String> loginUser(String email, String password);
}