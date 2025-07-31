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
              separatorBuilder: (_, __) => const Divider(),
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
    final isCancelled = appointment.cancelled;
    return Card(
      child: ListTile(
        title: Text("Dr. ${appointment.docData['name'] ?? 'Unknown'}"),
        subtitle: Text(
          "${appointment.slotDate} at ${appointment.slotTime}",
        ),
        trailing: isCancelled
            ? const Text(
                "Cancelled",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              )
            : TextButton(
                onPressed: onCancel,
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
              ),
      ),
    );
  }
}
