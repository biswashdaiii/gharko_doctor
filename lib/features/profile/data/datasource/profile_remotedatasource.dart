import 'package:gharko_doctor/core/network/api_service.dart';
import 'package:gharko_doctor/features/profile/data/models/profile_model.dart';

abstract class IUserProfileRemoteDataSource {
  Future<UserProfileModel> fetchUserProfile(String userId, String token);
  Future<void> updateUserProfile(UserProfileModel profile, String token);
}

class UserProfileRemoteDataSourceImpl implements IUserProfileRemoteDataSource {
  final ApiService apiService;

  UserProfileRemoteDataSourceImpl({required this.apiService});

  @override
  Future<UserProfileModel> fetchUserProfile(String userId, String token) async {
    final response = await apiService.get(
      '/user/profile/$userId',
      headers: {'Authorization': 'Bearer $token'},
    );
    return UserProfileModel.fromJson(response.data);
  }

  @override
  Future<void> updateUserProfile(UserProfileModel profile, String token) async {
    await apiService.put(
      '/user/profile/${profile.id}',
      data: profile.toJson(),
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
