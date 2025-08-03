import 'package:gharko_doctor/features/profile/domain/entity/profile_entity.dart';

abstract class IUserProfileRepository {
  Future<UserProfileEntity> getProfile(String userId);
  Future<void> updateProfile(UserProfileEntity profile);
}
