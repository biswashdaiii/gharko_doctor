import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/core/common/snackbar/snackbar.dart';
import 'package:gharko_doctor/features/authentication/domain/usecase/register_usecase.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/signup_event.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/signup_view_model/signup_state.dart';

class SignupViewModel extends Bloc<SignupEvent,SignupState>{
  final UserRegisterUseCase _userRegisterUseCase;

  SignupViewModel(
    this._userRegisterUseCase,

  ):super(SignupState.initial()){
    on<SignupEvent>(_onRegisterUser);
  }
  Future<void> _onRegisterUser(
    SignupEvent event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(isLoading: true ));
    

    final result = await _userRegisterUseCase(
      RegisterUserParams(
        username: event.username,
        phone: event.phone,
        password: event.password,
        email:event.email,
      ),
    );
    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
        ));
        showMySnackBar(
          context: event.context,
          message: failure.message,
          color: Colors.red,
        );
      },
      (r) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
        ));
         showMySnackBar(
          context: event.context,
          message: "Registration Successful",
        );
      },
    );
  }
}