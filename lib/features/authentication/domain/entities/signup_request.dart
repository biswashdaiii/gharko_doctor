import 'dart:io';

class SignupRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  final File? imageFile;

  const SignupRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    this.imageFile,
  });
}
