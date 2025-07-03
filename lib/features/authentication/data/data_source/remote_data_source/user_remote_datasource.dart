import 'package:dio/dio.dart';
import 'package:gharko_doctor/app/constant/api_endpoints.dart';
import 'package:gharko_doctor/core/network/api_service.dart';
import 'package:gharko_doctor/features/authentication/data/data_source/user-data_source.dart';
import 'package:gharko_doctor/features/authentication/data/model/user_api_model.dart';
import 'package:gharko_doctor/features/authentication/domain/entities/user_entity.dart';

class UserRemoteDatasource implements IUserDataSource{
  final ApiService _apiService;
 UserRemoteDatasource({
    required ApiService apiService,
  }) : _apiService = apiService;


  @override
  Future<UserEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<String> loginUser(String email, String password) {
    // TODO: implement loginUser
    throw UnimplementedError();
  }

  @override
  Future<void> registerUser(UserEntity user) async{
    try {
  final userApiModel = UserApiModel.fromEntity(user);
  print('Sending user data: ${userApiModel.toJson()}');

  final response = await _apiService.dio.post(
    ApiEndpoints.register,
    data: userApiModel.toJson(),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    print('✅ Registration successful');
    return;
  } else {
    throw Exception('Failed to register user: ${response.statusMessage}');
  }
} on DioException catch (e) {
  final errorMessage = e.response?.data['message'] ?? e.message;
  print('Dio error: $errorMessage');
  throw Exception('Failed to register user: $errorMessage');
} catch (e) {
  print('Unexpected error: $e');
  throw Exception('Failed to register user: $e');
}}}