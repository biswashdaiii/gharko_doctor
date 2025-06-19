import 'package:flutter/material.dart';

@immutable
sealed class SigninEvent {}

class NavigateToRegisterViewEvent extends SigninEvent {
  final BuildContext context;

  NavigateToRegisterViewEvent({required this.context});
}

class NavigateToHomeViewEvent extends SigninEvent {
  final BuildContext context;

  NavigateToHomeViewEvent({required this.context});
}

class LoginWithEmailAndPasswordEvent extends SigninEvent {
  final BuildContext context;
  final String username;
  final String password;

  LoginWithEmailAndPasswordEvent({
    required this.context,
    required this.username,
    required this.password,
  });
}