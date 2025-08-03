import 'dart:io';

import 'package:flutter/material.dart';
@immutable
sealed class RegisterEvent {
  get context => null;
}
class RegisterUserEvent extends RegisterEvent {
  final BuildContext context;
  final String fullName;
  final String password;
  final String email;

  RegisterUserEvent({
    required this.fullName,
    required this.email,
    required this.password,
     required this.context,
  });
}