import 'package:hive/hive.dart';

part 'appointment_model.g.dart';

@HiveType(typeId: 2)
class AppointmentModel {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String docId;

  @HiveField(2)
  final String slotDate;

  @HiveField(3)
  final String slotTime;

  @HiveField(4)
  final Map<String, dynamic> docData;

  @HiveField(5)
  final Map<String, dynamic> userData;

  @HiveField(6)
  final double amount;

  @HiveField(7)
  final DateTime date;

  @HiveField(8)
  final bool cancelled;

  @HiveField(9)
  final double? payment;

  @HiveField(10)
  final bool isCompleted;

  AppointmentModel({
    required this.userId,
    required this.docId,
    required this.slotDate,
    required this.slotTime,
    required this.docData,
    required this.userData,
    required this.amount,
    required this.date,
    required this.cancelled,
    this.payment,
    required this.isCompleted,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      userId: json['userId'],
      docId: json['docId'],
      slotDate: json['slotDate'],
      slotTime: json['slotTime'],
      docData: Map<String, dynamic>.from(json['docData']),
      userData: Map<String, dynamic>.from(json['userData']),
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date']),
      cancelled: json['cancelled'] ?? false,
      payment: json['payment'] != null ? (json['payment'] as num).toDouble() : null,
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'docId': docId,
      'slotDate': slotDate,
      'slotTime': slotTime,
      'docData': docData,
      'userData': userData,
      'amount': amount,
      'date': date.toIso8601String(),
      'cancelled': cancelled,
      'payment': payment,
      'isCompleted': isCompleted,
    };
  }
}
