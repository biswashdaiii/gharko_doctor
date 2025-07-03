import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/features/doctor/domain/entity/doctor_entity.dart';
import 'package:gharko_doctor/features/doctor/presentation/view/doctor_by_speciality.dart';
import 'package:gharko_doctor/features/doctor/presentation/view_model/doctor_bloc.dart';
import 'package:gharko_doctor/features/doctor/presentation/view_model/doctor_state.dart';

const List<String> specialties = [
  'General Physician',
  'Gynecologist',
  'Dermatologist',
  'Neurologist',
  'Pediatrician',
];

class DoctorDashboard extends StatelessWidget {
  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctors')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Doctors',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 140,
              child: BlocBuilder<DoctorBloc, DoctorState>(
                builder: (context, state) {
                  if (state is DoctorLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is DoctorLoaded) {
                    final recentDoctors = state.doctors.length > 3
                        ? state.doctors.sublist(0, 3)
                        : state.doctors;

                    if (recentDoctors.isEmpty) {
                      return const Center(child: Text('No doctors available'));
                    }

                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: recentDoctors.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final doctor = recentDoctors[index];
                        return _DoctorCard(doctor: doctor);
                      },
                    );
                  } else if (state is DoctorError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Specialities',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: specialties.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final speciality = specialties[index];
                  return ListTile(
                    title: Text(speciality),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DoctorsBySpecialityPage(speciality: speciality),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DoctorCard extends StatelessWidget {
  final DoctorEntity doctor;
  const _DoctorCard({required this.doctor, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.teal,
            child: Text(
              doctor.name.isNotEmpty ? doctor.name[0] : '',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            doctor.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            doctor.speciality,
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
