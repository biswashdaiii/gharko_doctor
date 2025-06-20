import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/core/common/snackbar/snackbar.dart';
import 'package:gharko_doctor/features/authentication/data/model/user_hive_model.dart';
import 'package:gharko_doctor/features/authentication/domain/usecase/register_usecase.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/signup_event.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/signup_state.dart';
import 'package:hive/hive.dart';

class SignupViewModel extends Bloc<SignupEvent, SignupState> {
  final UserRegisterUseCase _userRegisterUseCase;

  SignupViewModel(this._userRegisterUseCase) : super(SignupState.initial()) {
    on<RegisterUserEvent>(_onRegisterUser);
  }

  Future<void> _onRegisterUser(
  RegisterUserEvent event,
  Emitter<SignupState> emit,
) async {
  print("➡️ [Signup] Event received");
  emit(state.copyWith(isLoading: true));

  try {
    final result = await _userRegisterUseCase(
      RegisterUserParams(
        username: event.username,
        phone: event.phone,
        password: event.password,
      ),
    );
    print("✅ [Signup] UseCase returned");

    await result.fold(
      (failure) async {
        print("❌ [Signup] Failure: ${failure.message}");
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: failure.message,
          color: Colors.red,
        );
      },
      (_) async {
        print("🎉 [Signup] Success, token: ");
        final box = Hive.box<UserHiveModel>('userBox');
        await box.clear();
        await box.put(
          'user',
          UserHiveModel(
            username: event.username,
            phone: event.phone,
            password: '',
          ),
        );
        print("✅ [Signup] Saved to Hive");

        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: "Registration Successful",
        );
      },
    );
  } catch (e, st) {
    print("🚨 [Signup] Exception caught: $e\n$st");
    emit(state.copyWith(isLoading: false, isSuccess: false));
    showMySnackBar(
      context: event.context,
      message: "Unexpected error: $e",
      color: Colors.red,
    );
  }
}
}
