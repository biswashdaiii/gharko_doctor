import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/app/sharedPref/token_shared_pref.dart';
import 'package:gharko_doctor/core/common/snackbar/snackbar.dart';
import 'package:gharko_doctor/features/authentication/domain/usecase/login_usecase.dart';
import 'package:gharko_doctor/features/authentication/presentation/view/signup_screen.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/sigin_view_model/login_event.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/sigin_view_model/login_state.dart';
import 'package:gharko_doctor/features/dashboard/presentation/view/main_dashboard.dart';
import 'package:gharko_doctor/app/service_locator/service_locator.dart';

class LoginViewModel extends Bloc<SigninEvent, SigninState> {
  final UserLoginUsecase _userLoginUsecase;

  LoginViewModel(this._userLoginUsecase) : super(SigninState.initial()) {
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
        MaterialPageRoute(builder: (context) => SignupPage()),
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
        MaterialPageRoute(builder: (context) => MainDashboard()),
      );
    }
  }

  Future<void> _onLoginWithEmailAndPassword(
    LoginWithEmailAndPasswordEvent event,
    Emitter<SigninState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _userLoginUsecase(
      LoginUsecaseParams(
        email: event.email,
        password: event.password,
      ),
    );

    await result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: 'Invalid credentials. Please try again.',
          color: Colors.red,
        );
      },
      (token) async {
        // Save token using TokenSharedPrefs
        final saveResult = await serviceLocator<TokenSharedPrefs>().saveToken(token);
        saveResult.fold(
          (saveFailure) {
            showMySnackBar(
              context: event.context,
              message: 'Failed to save token: ${saveFailure.message}',
              color: Colors.red,
            );
            emit(state.copyWith(isLoading: false, isSuccess: false));
          },
          (_) {
            emit(state.copyWith(isLoading: false, isSuccess: true));
            add(NavigateToHomeViewEvent(context: event.context));
          },
        );
      },
    );
  }
}
