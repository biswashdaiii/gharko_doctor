import 'package:gharko_doctor/app/sharedPref/token_shared_pref.dart';
import 'package:gharko_doctor/features/profile/data/datasource/profile_remotedatasource.dart';
import 'package:gharko_doctor/features/profile/data/models/profile_model.dart';
import 'package:gharko_doctor/features/profile/domain/entity/profile_entity.dart';
import 'package:gharko_doctor/features/profile/domain/reposittory/profile_repository.dart';

class UserProfileRepositoryImpl implements IUserProfileRepository {
  final IUserProfileRemoteDataSource remoteDataSource;
  final TokenSharedPrefs tokenSharedPrefs;

  UserProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.tokenSharedPrefs,
  });

@override
Future<UserProfileEntity> getProfile(String userId) async {
  final tokenResult = await tokenSharedPrefs.getToken();
  if (tokenResult.isLeft()) throw Exception("Token not found");

  final token = tokenResult.getOrElse(() => null);
  if (token == null) throw Exception("Token is null");

  // Fetch UserProfileModel from remote and convert to UserProfileEntity
  final model = await remoteDataSource.fetchUserProfile(userId, token);
  return model.toEntity();
}

@override
Future<void> updateProfile(UserProfileEntity profile) async {
  final tokenResult = await tokenSharedPrefs.getToken();
  if (tokenResult.isLeft()) throw Exception("Token not found");

  final token = tokenResult.getOrElse(() => null);
  if (token == null) throw Exception("Token is null");

  // Convert entity to model before sending to remote
  final model = UserProfileModel.fromEntity(profile);
  await remoteDataSource.updateUserProfile(model, token);
}
}