import 'package:equatable/equatable.dart';
import 'package:gharko_doctor/features/profile/domain/entity/profile_entity.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {
  final String userId;

  const LoadProfile(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UpdateProfile extends ProfileEvent {
  final UserProfileEntity profile;

  const UpdateProfile(this.profile);

  @override
  List<Object?> get props => [profile];
}
