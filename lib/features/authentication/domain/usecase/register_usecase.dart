import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gharko_doctor/app/usecase/usecase.dart';
import 'package:gharko_doctor/core/error/failure.dart';
import 'package:gharko_doctor/features/authentication/domain/entities/user_entity.dart';
import 'package:gharko_doctor/features/authentication/domain/repository/user_repository.dart';
import 'package:uuid/uuid.dart';

class RegisterUserParams extends Equatable {
  final String username;
  final String phone;
  final String password;

  const RegisterUserParams({
    required this.username,
    required this.phone,
    required this.password,
  });

  @override
  List<Object?> get props => [username, phone, password];
}

class UserRegisterUseCase
    implements UsecaseWithParams<void, RegisterUserParams> {
  final IUserRepository _userRepository;

  UserRegisterUseCase({required IUserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final userEntity = UserEntity(
      username: params.username,
      phone: params.phone,
      password: params.password,
      userId: const  Uuid().v4(), // You can generate a UUID here if needed
    );
    return _userRepository.registerUser(userEntity);
  }
}
