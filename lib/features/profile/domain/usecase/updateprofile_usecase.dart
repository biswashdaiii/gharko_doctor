import 'package:gharko_doctor/features/profile/domain/entity/profile_entity.dart';
import 'package:gharko_doctor/features/profile/domain/reposittory/profile_repository.dart';

class UpdateProfileUseCase {
  final IUserProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<void> call(UserProfileEntity profile) {
    return repository.updateProfile(profile);
  }
}
