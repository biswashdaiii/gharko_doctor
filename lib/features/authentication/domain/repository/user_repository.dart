import 'package:gharko_doctor/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:gharko_doctor/features/authentication/domain/entities/user_entity.dart';

abstract interface class IUserRepository {
  Future<Either<Failure, void>> registerUser(UserEntity student);

  Future<Either<Failure, String>> loginUser(
    String username,
    String password,
  );
  UserEntity?getCurrentUser(String email);

}