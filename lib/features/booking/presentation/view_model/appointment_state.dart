import 'package:equatable/equatable.dart';

class AppointmentState extends Equatable {
  final DateTime selectedDate;
  final String selectedTimeSlot;
  final bool isLoading;
  final bool bookingSuccess;
  final String? errorMessage;

  const AppointmentState({
    required this.selectedDate,
    required this.selectedTimeSlot,
    this.isLoading = false,
    this.bookingSuccess = false,
    this.errorMessage,
  });

  AppointmentState copyWith({
    DateTime? selectedDate,
    String? selectedTimeSlot,
    bool? isLoading,
    bool? bookingSuccess,
    String? errorMessage,
  }) {
    return AppointmentState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      isLoading: isLoading ?? this.isLoading,
      bookingSuccess: bookingSuccess ?? this.bookingSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [selectedDate, selectedTimeSlot, isLoading, bookingSuccess, errorMessage];
}
