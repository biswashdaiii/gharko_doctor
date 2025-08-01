class AppointmentModel {
  final String userId;
  final String docId;
  final String slotDate;
  final String slotTime;
  final Map<String, dynamic> docData;
  final Map<String, dynamic>? userData;
  final double amount;
  final String date;
  final bool cancelled;
  final double? payment;
  final bool isCompleted;
  final String? createdDate; // ✅ Added

  AppointmentModel({
    required this.userId,
    required this.docId,
    required this.slotDate,
    required this.slotTime,
    required this.docData,
    this.userData, // ✅ make it nullable if optional
    required this.amount,
    required this.date,
    required this.cancelled,
    this.payment, // ✅ make it nullable if optional
    required this.isCompleted,
    this.createdDate, // ✅ added here
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      userId: json['userId'] ?? '',
      docId: json['docId'] ?? '',
      slotDate: json['slotDate'] ?? '',
      slotTime: json['slotTime'] ?? '',
      docData: json['docData'] ?? {},
      userData: json['userData'], // ✅ safe for nullable
      amount: (json['amount'] ?? 0).toDouble(),
      date: json['date'] ?? '',
      cancelled: json['cancelled'] ?? false,
      payment: (json['payment'] != null) ? (json['payment'] as num).toDouble() : null,
      isCompleted: json['isCompleted'] ?? false,
      createdDate: json['createdDate'], // ✅ added
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
      'date': date,
      'cancelled': cancelled,
      'payment': payment,
      'isCompleted': isCompleted,
      'createdDate': createdDate,
    };
  }
}
