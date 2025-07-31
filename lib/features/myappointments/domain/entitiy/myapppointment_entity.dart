class MyAppointmentEntity {
  final String id;
  final Map<String, dynamic> docData; // doctor info map
  final String slotDate;
  final String slotTime;
  final double amount;
  final bool cancelled;  // note the name must be `cancelled` to match your UI
  final bool isCompleted;

  MyAppointmentEntity({
    required this.id,
    required this.docData,
    required this.slotDate,
    required this.slotTime,
    required this.amount,
    required this.cancelled,
    required this.isCompleted,
  });
}
