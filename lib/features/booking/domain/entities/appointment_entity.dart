class AppointmentEntity {
  final String userId;
  final String docId;
  final String slotDate;
  final String slotTime;
  final Map<String, dynamic> docData;
  final Map<String, dynamic> userData;
  final double amount;
  final DateTime date;
  final bool cancelled;
  final double? payment;
  final bool isCompleted;

  AppointmentEntity({
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
}
