import 'dart:convert';
import 'package:gharko_doctor/features/myappointments/data/model/myappointment_model.dart';
import 'package:http/http.dart' as http;
import 'package:gharko_doctor/core/error/exception.dart';

abstract class MyAppointmentRemoteDataSource {
  Future<List<MyAppointmentModel>> getMyAppointments(String token);
  Future<void> cancelAppointment(String appointmentId, String token);
}
