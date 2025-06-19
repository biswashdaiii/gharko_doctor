import 'dart:io';

import 'package:flutter/material.dart';
@immutable
sealed class SignupEvent {
  get context => null;
}
class SignupUserEvent extends SignupEvent {
  final String username;
  final String password;
  final String confirmPassword;
  final String phone;
    final BuildContext context;

  SignupUserEvent({
    required this.username,
    required this.phone,
    required this.password,
    required this.confirmPassword,
    required this.context,
  });


}