import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/features/myappointments/domain/entitiy/myapppointment_entity.dart';

import 'package:gharko_doctor/features/myappointments/domain/usecase/cancel_appointment_usecase.dart';
import 'package:gharko_doctor/features/myappointments/domain/usecase/get_appointment_usecase.dart';
import 'package:gharko_doctor/features/myappointments/presentation/view_model/myappointments_bloc.dart';
import 'package:gharko_doctor/features/myappointments/presentation/view_model/myappointments_event.dart';
import 'package:gharko_doctor/features/myappointments/presentation/view_model/myappointments_state.dart';

class MyAppointmentsPage extends StatelessWidget {
  const MyAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyAppointmentsBloc(
        getUserAppointmentsUseCase: context.read<GetUserAppointmentsUseCase>(),
        cancelUserAppointmentUseCase: context.read<CancelUserAppointmentUseCase>(),
      )..add(LoadAppointments()),
      child: Scaffold(
        appBar: AppBar(title: const Text("My Appointments")),
        body: BlocBuilder<MyAppointmentsBloc, MyAppointmentsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null) {
              return Center(child: Text("Error: ${state.errorMessage}"));
            }

            if (state.appointments.isEmpty) {
              return const Center(child: Text("No appointments found."));
            }

            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: state.appointments.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final appointment = state.appointments[index];
                return AppointmentCard(
                  appointment: appointment,
                  onCancel: () {
                    context.read<MyAppointmentsBloc>().add(
                          CancelAppointment(appointment.id),
                        );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final MyAppointmentEntity appointment;
  final VoidCallback onCancel;

  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final doctor = appointment.docData;
    final isCancelled = appointment.cancelled;

    final doctorName = doctor['name'] ?? 'Unknown Doctor';
    final specialty = doctor['speciality'] ?? '';
    final imagePath = doctor['image'] ?? '';
    final imageUrl = imagePath.isNotEmpty
        ? 'http://192.168.1.77:5050/${imagePath.replaceAll("\\", "/")}'
        : '';

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey.shade200,
              backgroundImage:
                  imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
              child: imageUrl.isEmpty
                  ? Text(
                      doctorName.isNotEmpty ? doctorName[0] : '',
                      style: const TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dr. $doctorName",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (specialty.isNotEmpty)
                    Text(
                      specialty,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    "${appointment.slotDate} at ${appointment.slotTime}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            isCancelled
                ? const Text(
                    "Cancelled",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : TextButton(
                    onPressed: onCancel,
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
