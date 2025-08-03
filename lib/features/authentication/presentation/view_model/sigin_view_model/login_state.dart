import 'package:equatable/equatable.dart';

class SigninState extends Equatable {
  final bool isLoading;
  final bool isSuccess;

  const SigninState({required this.isLoading, required this.isSuccess});

  const SigninState.initial() : isLoading = false, isSuccess = false;

  SigninState copyWith({bool? isLoading, bool? isSuccess}) {
    return SigninState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess];
}