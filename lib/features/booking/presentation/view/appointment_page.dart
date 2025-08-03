import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/features/booking/presentation/view_model/appointment_bloc.dart';
import 'package:gharko_doctor/features/booking/presentation/view_model/appointment_event.dart';
import 'package:gharko_doctor/features/booking/presentation/view_model/appointment_state.dart';
import 'package:intl/intl.dart';

class AppointmentPage extends StatelessWidget {
  final String doctorId;
  final String doctorName;
  final String specialty;
  final int experienceYears;
  final String about;
  final double fee;
  final String doctorImageUrl;

  AppointmentPage({
    super.key,
    required this.doctorId,
    required this.doctorName,
    required this.specialty,
    required this.experienceYears,
    required this.about,
    required this.fee,
    required this.doctorImageUrl,
  });

  List<String> generateTimeSlots(BuildContext context) {
    List<String> slots = [];
    for (int hour = 10; hour <= 17; hour += 2) {
      final time = TimeOfDay(hour: hour, minute: 0);
      slots.add(time.format(context));
    }
    return slots;
  }

  @override
  Widget build(BuildContext context) {
    final timeSlots = generateTimeSlots(context);
    final tomorrow = DateTime.now().add(const Duration(days: 1));

    // TODO: Replace these with your actual logged-in user data
    const userName = 'John Doe';
    const userEmail = 'john@example.com';
    const userPhone = '+1234567890';

    return BlocProvider(
      create: (_) =>
          AppointmentBloc(bookAppointmentUseCase: context.read())
            ..add(SelectDate(tomorrow))
            ..add(SelectTimeSlot(timeSlots.first)),
      child: BlocConsumer<AppointmentBloc, AppointmentState>(
        listener: (context, state) {
          if (state.bookingSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Appointment booked successfully!')),
            );
          }
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Book Appointment')),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          doctorImageUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.teal.shade200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.medical_services,
                              size: 48,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doctorName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '$specialty - $experienceYears year${experienceYears > 1 ? 's' : ''}',
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'About',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  about,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Appointment fee: \$${fee.toStringAsFixed(2)}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Select Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 60,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(7, (index) {
                              final date = tomorrow.add(Duration(days: index));
                              final isSelected =
                                  state.selectedDate.day == date.day &&
                                  state.selectedDate.month == date.month &&
                                  state.selectedDate.year == date.year;
                              return GestureDetector(
                                onTap: () => context.read<AppointmentBloc>().add(
                                      SelectDate(date),
                                    ),
                                child: Container(
                                  width: 60,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.teal
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: Colors.teal),
                                  ),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat.E().format(date),
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      Text(
                                        date.day.toString(),
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Select Time',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: timeSlots.map((time) {
                            final isSelected = state.selectedTimeSlot == time;
                            return GestureDetector(
                              onTap: () => context.read<AppointmentBloc>().add(
                                    SelectTimeSlot(time),
                                  ),
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.teal
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.teal),
                                ),
                                child: Text(
                                  time,
                                  style: TextStyle(
                                    color:
                                        isSelected ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (state.isLoading)
                        const Center(child: CircularProgressIndicator())
                      else
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<AppointmentBloc>().add(
                                BookAppointment(
                                  doctorId: doctorId,
                                  selectedDate: state.selectedDate,
                                  selectedTime: state.selectedTimeSlot,
                                  fee: fee,
                                  docData: {
                                    'name': doctorName,
                                    'specialty': specialty,
                                    'experienceYears': experienceYears,
                                    'imageUrl': doctorImageUrl,
                                  },
                                  userData: {
                                    'name': userName,
                                    'email': userEmail,
                                    'phone': userPhone,
                                  },
                                  createdDate: DateTime.now(), // Pass DateTime here
                                ),
                              );
                            },
                            child: const Text('Book Now'),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
