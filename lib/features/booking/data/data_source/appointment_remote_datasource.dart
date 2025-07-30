import 'dart:convert';
import 'package:gharko_doctor/app/constant/api_endpoints.dart';
import 'package:gharko_doctor/features/booking/data/data_source/appointment_datasource.dart';
import 'package:http/http.dart' as http;
import 'package:gharko_doctor/features/booking/data/model/appointment_model.dart';

class AppointmentRemoteDataSourceImpl implements IAppointmentRemoteDataSource {
  final http.Client client;

  AppointmentRemoteDataSourceImpl({required this.client});

  @override
  Future<List<AppointmentModel>> fetchAppointments(String token, {String? userId, String? docId}) async {
    final queryParams = <String, String>{};
    if (userId != null) queryParams['userId'] = userId;
    if (docId != null) queryParams['docId'] = docId;

    final uri = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.getAppointments)
        .replace(queryParameters: queryParams);

    final response = await client.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((item) => AppointmentModel.fromJson(item)).toList();
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
      throw Exception('Failed to book appointment');
    }
  }

  @override
  Future<void> cancelAppointment(String appointmentId, String token) async {
    final uri = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.cancelAppointment(appointmentId));

    final response = await client.patch(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to cancel appointment');
    }
  }
}
