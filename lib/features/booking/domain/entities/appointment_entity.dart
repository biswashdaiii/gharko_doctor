class AppointmentEntity {
  final String? userId;
  final String docId;
  final String slotDate; // yyyy-MM-dd string
  final String slotTime;
  final Map<String, dynamic> docData;
  final Map<String, dynamic>? userData;
  final double amount;
  final String date; // booking creation date in ISO string
  final bool cancelled;
  final double? payment;
  final bool isCompleted;
  final String? createdDate;

  AppointmentEntity({
    this.userId,
    required this.docId,
    required this.slotDate,
    required this.slotTime,
    required this.docData,
    this.userData,
    required this.amount,
    required this.date,
    required this.cancelled,
    this.payment,
    required this.isCompleted,
    this.createdDate,
  });
}
