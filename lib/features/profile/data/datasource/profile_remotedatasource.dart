import 'package:gharko_doctor/core/network/api_service.dart';
import 'package:gharko_doctor/features/profile/data/models/profile_model.dart';

abstract class IUserProfileRemoteDataSource {
  Future<UserProfileModel> fetchUserProfile(String token);
  Future<void> updateUserProfile(UserProfileModel profile, String token);
}

class UserProfileRemoteDataSourceImpl implements IUserProfileRemoteDataSource {
  final ApiService apiService;

  UserProfileRemoteDataSourceImpl({required this.apiService});

  @override
  Future<UserProfileModel> fetchUserProfile(String token) async {
    try {
      print('📛 Calling fetchUserProfile');

      final response = await apiService.get(
        '/user/get-profile',
        headers: {'Authorization': 'Bearer $token'},
      );

      print("✅ Raw response data: ${response.data}");

      // Use response.data directly since backend returns the user JSON directly
      final data = response.data;

      final profile = UserProfileModel.fromJson(data);
      print("✅ Parsed profile: $profile");
      return profile;
    } catch (e, stackTrace) {
      print('❌ Error fetching user profile: $e');
      print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> updateUserProfile(UserProfileModel profile, String token) async {
    try {
      final data = {
        'name': profile.name,
        'email': profile.email,
        'phone': profile.phone,
      };

      final imageFilePath = profile.avatarUrl;
      final isImageLocal = imageFilePath.startsWith('/');

      if (isImageLocal) {
        print('📷 Uploading local image from path: $imageFilePath');
      } else {
        print(
          '🌐 Using existing image URL (not uploading a file): $imageFilePath',
        );
      }

      final formData = await apiService.createMultipartData(
        data: data,
        fileField:
            isImageLocal
                ? 'image'
                : null, // Your backend expects 'image' as file field
        filePath: isImageLocal ? imageFilePath : null,
      );

      print("📦 FormData content: $formData");

      final response = await apiService.put(
        '/user/update-profile',
        data: formData,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      );

      print("✅ Profile update response: ${response.data}");
    } catch (e, stackTrace) {
      print('❌ Error updating user profile: $e');
      print(stackTrace);
      rethrow;
    }
  }
}
