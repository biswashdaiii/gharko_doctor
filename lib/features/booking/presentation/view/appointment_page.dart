import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  final List<String> timeSlots = ['07:30 pm', '08:00 pm', '08:30 pm'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Image
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

                // Doctor Info
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
                      child: const Icon(Icons.medical_services, size: 48, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctorName,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text('$specialty - $experienceYears year${experienceYears > 1 ? 's' : ''}'),
                          const SizedBox(height: 8),
                          const Text('About', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(about, maxLines: 3, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 8),
                          Text('Appointment fee: \$${fee.toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                const Text('Booking Slots', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),

                // Date selector: horizontal scroll using SingleChildScrollView + Row
                SizedBox(
                  height: 60,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(7, (index) {
                        final date = DateTime.now().add(Duration(days: index));
                        // For demo, no selected logic here, you can plug state here
                        final isSelected = false;
                        return GestureDetector(
                          onTap: () {
                            // Handle date tap
                          },
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
                                Text(
                                  DateFormat.E().format(date),
                                  style: TextStyle(color: isSelected ? Colors.white : Colors.black),
                                ),
                                Text(
                                  date.day.toString(),
                                  style: TextStyle(color: isSelected ? Colors.white : Colors.black),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Time slots horizontal scroll using SingleChildScrollView + Row
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: timeSlots.map((time) {
                      // For demo, no selection logic here
                      final isSelected = false;
                      return GestureDetector(
                        onTap: () {
                          // Handle time tap
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.teal : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.teal),
                          ),
                          child: Text(
                            time,
                            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle book appointment
                    },
                    child: const Text('Book an Appointment'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
