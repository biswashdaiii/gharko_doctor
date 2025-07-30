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

  AppointmentPage({
    Key? key,
    required this.doctorId,
    required this.doctorName,
    required this.specialty,
    required this.experienceYears,
    required this.about,
    required this.fee,
  }) : super(key: key);

  final List<String> timeSlots = ['07:30 pm', '08:00 pm', '08:30 pm'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppointmentBloc(),
      child: Scaffold(
        appBar: AppBar(title: Text('Book Appointment')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<AppointmentBloc, AppointmentState>(
            listener: (context, state) {
              if (state.bookingSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Appointment booked successfully!')),
                );
                Navigator.pop(context); // go back after success
              }
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );
              }
            },
            builder: (context, state) {
              final bloc = context.read<AppointmentBloc>();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Doctor Info
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.teal.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.medical_services, size: 48, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(doctorName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            Text('$specialty - $experienceYears year${experienceYears > 1 ? 's' : ''}'),
                            const SizedBox(height: 8),
                            Text('About', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(about),
                            const SizedBox(height: 8),
                            Text('Appointment fee: \$${fee.toStringAsFixed(2)}'),
                          ],
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 24),

                  const Text('Booking Slots', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

                  const SizedBox(height: 12),

                  // Date selector horizontal scroll
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        final date = DateTime.now().add(Duration(days: index));
                        final isSelected = state.selectedDate.year == date.year &&
                            state.selectedDate.month == date.month &&
                            state.selectedDate.day == date.day;
                        return GestureDetector(
                          onTap: () => bloc.add(SelectDate(date)),
                          child: Container(
                            width: 60,
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.teal : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.teal),
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(DateFormat.E().format(date), style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
                                Text(date.day.toString(), style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Time slots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: timeSlots.map((time) {
                      final isSelected = time == state.selectedTimeSlot;
                      return GestureDetector(
                        onTap: () => bloc.add(SelectTimeSlot(time)),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.teal : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.teal),
                          ),
                          child: Text(time, style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // Book button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.isLoading
                          ? null
                          : () {
                              bloc.add(BookAppointment(
                                doctorId: doctorId,
                                selectedDate: state.selectedDate,
                                selectedTime: state.selectedTimeSlot,
                                fee: fee,
                              ));
                            },
                      child: state.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Book an Appointment'),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
