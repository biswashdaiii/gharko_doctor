import 'dart:convert';
import 'package:gharko_doctor/features/myappointments/data/datasource/abstractRemotedatasource.dart';
import 'package:gharko_doctor/features/myappointments/data/model/myappointment_model.dart';
import 'package:http/http.dart' as http;
import 'package:gharko_doctor/core/error/exception.dart';

class MyAppointmentRemoteDataSourceImpl implements MyAppointmentRemoteDataSource {
  final http.Client client;

  MyAppointmentRemoteDataSourceImpl({required this.client});

  final String baseUrl = 'http://192.168.1.77:5050/api/user'; // Adjust if needed

  @override
  Future<List<MyAppointmentModel>> getMyAppointments(String token) async {
    print('Fetching appointments with token: $token');
    final response = await client.get(
      Uri.parse('$baseUrl/my-appointments'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = jsonDecode(response.body);

      if (jsonMap['success'] == true && jsonMap['appointments'] != null) {
        final List<dynamic> jsonList = jsonMap['appointments'];
        return jsonList.map((json) => MyAppointmentModel.fromJson(json)).toList();
      } else {
        throw ServerException(
          message: 'Invalid response structure',
          statusCode: response.statusCode,
        );
      }
    } else {
      throw ServerException(
        message: 'Failed to load appointments',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<void> cancelAppointment(String appointmentId, String token) async {
    final response = await client.post(
      Uri.parse('$baseUrl/cancel-appointment'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'appointmentId': appointmentId}),
    );

    if (response.statusCode != 200) {
      throw ServerException(
        message: 'Failed to cancel appointment',
        statusCode: response.statusCode,
      );
    }
  }
}
