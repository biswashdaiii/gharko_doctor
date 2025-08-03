import 'package:gharko_doctor/features/profile/domain/entity/profile_entity.dart';
import 'package:gharko_doctor/features/profile/domain/reposittory/profile_repository.dart';

class GetProfileUseCase {
  final IUserProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<UserProfileEntity> call() {
    // No userId needed now
    return repository.getProfile('');
  }
}