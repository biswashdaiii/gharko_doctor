import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/core/common/snackbar/snackbar.dart';
import 'package:gharko_doctor/features/authentication/data/model/user_hive_model.dart';
import 'package:gharko_doctor/features/authentication/domain/usecase/register_usecase.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/register_event.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/register_state.dart';
import 'package:hive/hive.dart';
class RegisterViewModel extends Bloc<RegisterEvent, RegisterState> {
  final UserRegisterUseCase _registerUseCase;

  RegisterViewModel({
    required UserRegisterUseCase registerUseCase,
  })  : _registerUseCase = registerUseCase,
        super(RegisterState.initial()) {
    on<RegisterUserEvent>(_registerUserEvent);
  }

  Future<void> _registerUserEvent(
    RegisterUserEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _registerUseCase(
      RegisterUserParams(
        fullName: event.fullName,
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: "Registration Failed: ${failure.message}",
        );
      },
      (success) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: "Registration Successful",
        );
      },
    );
  }
}
