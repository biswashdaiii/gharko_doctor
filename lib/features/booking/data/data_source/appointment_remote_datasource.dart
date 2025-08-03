import 'dart:convert';
import 'package:gharko_doctor/core/network/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:gharko_doctor/app/constant/api_endpoints.dart';
import '../model/appointment_model.dart';

abstract interface class IAppointmentRemoteDataSource {
  Future<List<AppointmentModel>> fetchAppointments(String token, {String? userId, String? docId});
  Future<void> bookAppointment(AppointmentModel appointment, String token);
  Future<void> cancelAppointment(String appointmentId, String token);
}

class AppointmentRemoteDataSourceImpl implements IAppointmentRemoteDataSource {
  final http.Client client;
  final ApiService  apiService;

  AppointmentRemoteDataSourceImpl({required this.client,required this.apiService});

  @override
  Future<List<AppointmentModel>> fetchAppointments(String token, {String? userId, String? docId}) async {
    final queryParams = <String, String>{};
    if (userId != null) queryParams['userId'] = userId;
    if (docId != null) queryParams['docId'] = docId;

    final uri = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.getAppointments).replace(queryParameters: queryParams);

    final response = await client.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((jsonItem) => AppointmentModel.fromJson(jsonItem)).toList();
    } else {
      throw Exception('Failed to fetch appointments');
    }
  }

  @override
  Future<void> bookAppointment(AppointmentModel appointment, String token) async {
    final uri = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.bookAppointment);

    final response = await client.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(appointment.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      String errorMessage = 'Failed to book appointment';
      try {
        final Map<String, dynamic> errorJson = json.decode(response.body);
        if (errorJson.containsKey('message')) errorMessage = errorJson['message'];
      } catch (_) {}
      throw Exception(errorMessage);
    }
  }

  @override
  Future<void> cancelAppointment(String appointmentId, String token) async {
    final uri = Uri.parse("${ApiEndpoints.baseUrl}${ApiEndpoints.cancelAppointment}/$appointmentId");

    final response = await client.delete(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to cancel appointment');
    }
  }
}
