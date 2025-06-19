import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  final bool isLoading;
  final bool isSuccess;

  const SignupState({
    this.isLoading = false,
    this.isSuccess = false,
  });
  const SignupState.initial()
      : isLoading = false,
        isSuccess = false;
  SignupState copyWith({
    bool? isLoading,
    bool? isSuccess,
  }) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [
    isLoading,
    isSuccess,
  ];
}