import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gharko_doctor/app/usecase/usecase.dart';
import 'package:gharko_doctor/core/error/failure.dart';
import 'package:gharko_doctor/features/authentication/domain/repository/user_repository.dart';

class LoginUsecaseParams extends Equatable {
  final String email;
  final String password;  

  const LoginUsecaseParams({
    required this.email,
    required this.password,
  });

const LoginUsecaseParams.initial()
      : email = '',
        password = '';
  @override
  
  List<Object?> get props => [email, password];

}
class UserLoginUsecase implements UsecaseWithParams<String, LoginUsecaseParams> {
  final IUserRepository _userRepository;
  
   UserLoginUsecase({required IUserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Either<Failure, String>> call(LoginUsecaseParams params) async{
   return await _userRepository.loginUser(
      params.email,
      params.password,
    );
  }
 
}