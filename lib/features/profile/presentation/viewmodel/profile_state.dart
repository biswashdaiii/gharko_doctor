import 'package:equatable/equatable.dart';
import 'package:gharko_doctor/features/profile/domain/entity/profile_entity.dart';

class ProfileState extends Equatable {
  final UserProfileEntity? profile;
  final bool isLoading;
  final String? error;

  const ProfileState({this.profile, this.isLoading = false, this.error});

  ProfileState copyWith({
    UserProfileEntity? profile,
    bool? isLoading,
    String? error,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [profile, isLoading, error];
}
