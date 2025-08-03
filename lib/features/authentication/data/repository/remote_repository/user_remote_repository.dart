import 'package:dartz/dartz.dart';
import 'package:gharko_doctor/core/error/failure.dart';
import 'package:gharko_doctor/features/authentication/data/data_source/remote_data_source/user_remote_datasource.dart';
import 'package:gharko_doctor/features/authentication/domain/entities/user_entity.dart';
import 'package:gharko_doctor/features/authentication/domain/repository/user_repository.dart';

class UserRemoteRepository implements IUserRepository{
  final UserRemoteDatasource _userRemoteDatasource;
  UserRemoteRepository({
    required UserRemoteDatasource userRemoteDatasource,
  }) : _userRemoteDatasource = userRemoteDatasource;

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> loginUser(String email, String password)async {
    try {
      final token = await _userRemoteDatasource.loginUser(email, password);
      return Right(token);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
   
  }

  @override
  Future<Either<Failure, void>> registerUser(UserEntity user) async{
      try {
      await _userRemoteDatasource.registerUser(user);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }
}