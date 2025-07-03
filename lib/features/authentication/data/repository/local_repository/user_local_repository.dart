import 'package:dartz/dartz.dart';
import 'package:gharko_doctor/core/error/failure.dart';
import 'package:gharko_doctor/features/authentication/data/data_source/local_data_source/user_local_data_source.dart';
import 'package:gharko_doctor/features/authentication/domain/entities/user_entity.dart';
import 'package:gharko_doctor/features/authentication/domain/repository/user_repository.dart';

class UserLocalRepository implements IUserRepository{
  final UserLocalDataSource _userLocalDataSource;

  UserLocalRepository({
    required UserLocalDataSource userLocalDataSource,
  }) : _userLocalDataSource = userLocalDataSource;

 
  @override
  Future<Either<Failure, String>> loginUser(String email, String password) async {
    try {
      final result = await _userLocalDataSource.loginUser(
        email,
        password,
      );
      return Right(result);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Failed to login: $e"));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(UserEntity student) async{
    try {
      await _userLocalDataSource.registerUser(student);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: 'Registration failed: $e'));
    }
  }
  
  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }
}