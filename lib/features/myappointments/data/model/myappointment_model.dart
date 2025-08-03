import 'package:gharko_doctor/features/myappointments/domain/entitiy/myapppointment_entity.dart';

class MyAppointmentModel extends MyAppointmentEntity {
  MyAppointmentModel({
    required String id,
    required Map<String, dynamic> docData,
    required String slotDate,
    required String slotTime,
    required double amount,
    required bool cancelled,
    required bool isCompleted,
  }) : super(
          id: id,
          docData: docData,
          slotDate: slotDate,
          slotTime: slotTime,
          amount: amount,
          cancelled: cancelled,
          isCompleted: isCompleted,
        );

  factory MyAppointmentModel.fromJson(Map<String, dynamic> json) {
    return MyAppointmentModel(
      id: json['_id'] as String,
      docData: Map<String, dynamic>.from(json['docData']),
      slotDate: json['slotDate'] as String,
      slotTime: json['slotTime'] as String,
      amount: (json['amount'] as num).toDouble(),
      cancelled: json['cancelled'] ?? false,
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}
