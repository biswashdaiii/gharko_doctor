import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/features/profile/domain/usecase/getprofile_usecase.dart';
import 'package:gharko_doctor/features/profile/domain/usecase/updateprofile_usecase.dart';
import 'package:gharko_doctor/features/profile/presentation/viewmodel/profile_event.dart';
import 'package:gharko_doctor/features/profile/presentation/viewmodel/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  ProfileBloc({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
  }) : super(const ProfileState()) {
    on<LoadProfile>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: null));
      try {
        final profile = await getProfileUseCase();
        emit(state.copyWith(profile: profile, isLoading: false));
      } catch (e) {
        emit(state.copyWith(error: e.toString(), isLoading: false));
      }
    });

    on<UpdateProfile>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: null));
      try {
        await updateProfileUseCase(event.profile);
        final freshProfile = await getProfileUseCase();
        emit(state.copyWith(profile: freshProfile, isLoading: false));
      } catch (e) {
        emit(state.copyWith(error: e.toString(), isLoading: false));
      }
    });
  }
}
