import 'package:gharko_doctor/features/profile/data/datasource/profile_remotedatasource.dart';
import 'package:gharko_doctor/features/profile/data/models/profile_model.dart';
import 'package:gharko_doctor/features/profile/domain/entity/profile_entity.dart';
import 'package:gharko_doctor/features/profile/domain/reposittory/profile_repository.dart';
import 'package:gharko_doctor/app/sharedPref/token_shared_pref.dart';

class UserProfileRepositoryImpl implements IUserProfileRepository {
  final IUserProfileRemoteDataSource remoteDataSource;
  final TokenSharedPrefs tokenSharedPrefs;

  UserProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.tokenSharedPrefs,
  });

  @override
  Future<UserProfileEntity> getProfile(String userId) async {
    // We don't need userId since backend fetches from token
    final tokenResult = await tokenSharedPrefs.getToken();
    if (tokenResult.isLeft()) throw Exception("Token not found");

    final token = tokenResult.getOrElse(() => null);
    if (token == null) throw Exception("Token is null");

    final model = await remoteDataSource.fetchUserProfile(token);
    return model.toEntity();
  }

  @override
  Future<void> updateProfile(UserProfileEntity profile) async {
    final tokenResult = await tokenSharedPrefs.getToken();
    if (tokenResult.isLeft()) throw Exception("Token not found");

    final token = tokenResult.getOrElse(() => null);
    if (token == null) throw Exception("Token is null");

    final model = UserProfileModel.fromEntity(profile);
    await remoteDataSource.updateUserProfile(model, token);
  }
}
