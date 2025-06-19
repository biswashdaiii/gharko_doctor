import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/app/service_locator/service_locator.dart';
import 'package:gharko_doctor/core/common/snackbar/snackbar.dart';
import 'package:gharko_doctor/features/authentication/domain/usecase/login_usecase.dart';
import 'package:gharko_doctor/features/authentication/presentation/view/signup_screen.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/sigin_view_model/signin_event.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/sigin_view_model/signin_state.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/signup_view_model.dart';
import 'package:gharko_doctor/screens/dashboard_screen.dart';

class LoginViewModel extends Bloc<SigninEvent, SigninState> {
  final UserLoginUsecase _UserLoginUsecase;

  LoginViewModel(this._UserLoginUsecase) : super(SigninState.initial()) {
    on<NavigateToRegisterViewEvent>(_onNavigateToRegisterView);
    on<NavigateToHomeViewEvent>(_onNavigateToHomeView);
    on<LoginWithEmailAndPasswordEvent>(_onLoginWithEmailAndPassword);
  }

  void _onNavigateToRegisterView(
    NavigateToRegisterViewEvent event,
    Emitter<SigninState> emit,
  ) {
    if (event.context.mounted) {
      Navigator.push(
        event.context,

        MaterialPageRoute(
          builder: (context) =>  SignupPage(),
        ),
      );
    }
  }

  void _onNavigateToHomeView(
    NavigateToHomeViewEvent event,
    Emitter<SigninState> emit,
  ) {
    if (event.context.mounted) {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ),
      );
    }
  }

  void _onLoginWithEmailAndPassword(
    LoginWithEmailAndPasswordEvent event,
    Emitter<SigninState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _UserLoginUsecase(
      LoginUsecaseParams(username: event.username, password: event.password),
    );

    result.fold(
      (failure) {
        // Handle failure case
        emit(state.copyWith(isLoading: false, isSuccess: false));

        showMySnackBar(
          context: event.context,
          message: 'Invalid credentials. Please try again.',
          color: Colors.red,
        );
      },
      (token) {
        // Handle success case
        emit(state.copyWith(isLoading: false, isSuccess: true));
        add(NavigateToHomeViewEvent(context: event.context));
      },
    );
  }
}