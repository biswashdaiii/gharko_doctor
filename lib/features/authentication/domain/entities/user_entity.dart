import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {

  final String phone;
  final String username;
  final String password;

  const UserEntity({
    required this.phone,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [
    phone,
    username,
    password,
  ];
}