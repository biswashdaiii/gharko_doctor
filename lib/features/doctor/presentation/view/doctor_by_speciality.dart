import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/features/doctor/presentation/view_model/doctor_bloc.dart';
import 'package:gharko_doctor/features/doctor/presentation/view_model/doctor_event.dart';
import 'package:gharko_doctor/features/doctor/presentation/view_model/doctor_state.dart';


class DoctorsBySpecialityPage extends StatefulWidget {
  final String speciality;

  const DoctorsBySpecialityPage({super.key, required this.speciality});

  @override
  State<DoctorsBySpecialityPage> createState() => _DoctorsBySpecialityPageState();
}

class _DoctorsBySpecialityPageState extends State<DoctorsBySpecialityPage> {
  @override
  void initState() {
    super.initState();
    // Fetch doctors filtered by speciality on page load
    context.read<DoctorBloc>().add(FetchDoctorsBySpecialityEvent(widget.speciality));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.speciality),
      ),
      body: BlocBuilder<DoctorBloc, DoctorState>(
        builder: (context, state) {
          if (state is DoctorLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DoctorLoaded) {
            if (state.doctors.isEmpty) {
              return const Center(child: Text('No doctors found'));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: state.doctors.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final doctor = state.doctors[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(doctor.name.isNotEmpty ? doctor.name[0] : ''),
                  ),
                  title: Text(doctor.name),
                  subtitle: Text(doctor.speciality),
                );
              },
            );
          } else if (state is DoctorError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
