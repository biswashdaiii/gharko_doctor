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
  UserEntity? getCurrentUser(String email) {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> loginUser(String username, String password) async{
   try {
      final userId = await _userLocalDataSource.loginUser(username, password);
      return Right(userId);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: 'Login failed: $e'));
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
}