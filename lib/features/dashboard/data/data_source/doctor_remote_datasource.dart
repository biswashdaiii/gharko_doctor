import 'package:dio/dio.dart';
import 'package:gharko_doctor/app/constant/api_endpoints.dart';
import 'package:gharko_doctor/core/network/api_service.dart';
import 'package:gharko_doctor/features/dashboard/data/data_source/doctor_datasource.dart';
import 'package:gharko_doctor/features/dashboard/data/model/doctor_api_model.dart';
import 'package:gharko_doctor/features/dashboard/domain/entity/doctor_entity.dart';

class DoctorRemoteDataSource implements IDoctorDataSource {
  final ApiService _apiService;

  DoctorRemoteDataSource({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<List<DoctorEntity>> getAllDoctors() async {
    try {
      final response = await _apiService.dio.get(ApiEndpoints.getAllDoctors);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['doctors'] ?? response.data;
        final doctors = data
            .map((json) => DoctorApiModel.fromJson(json).toEntity())
            .toList();
        return doctors;
      } else {
        throw Exception('Failed to load doctors: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message;
      throw Exception('Dio error: $errorMessage');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<List<DoctorEntity>> getDoctorsBySpeciality(String speciality) async {
    try {
      final response = await _apiService.dio.get(
        ApiEndpoints.getDoctorsBySpeciality,
        queryParameters: {'speciality': speciality},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['doctors'] ?? response.data;
        final doctors = data
            .map((json) => DoctorApiModel.fromJson(json).toEntity())
            .toList();
        return doctors;
      } else {
        throw Exception(
            'Failed to load doctors by speciality: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message;
      throw Exception('Dio error: $errorMessage');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
