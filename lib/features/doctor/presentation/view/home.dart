import 'package:flutter/material.dart';
import 'package:gharko_doctor/features/doctor/domain/entity/doctor_entity.dart';
class Home extends StatelessWidget {
  final Function(String) onSpecialityTap;
  final List<DoctorEntity> recentDoctors;

  Home({
    required this.onSpecialityTap,
    required this.recentDoctors,
    super.key,
  });

  final List<String> specialties = [
    'Gynecologist',
    'Dermatologist',
    'Neurologist',
    'General Physician',
  ];

  


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top welcome box
            Container(
              height: 300,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Welcome back!\nLet\'s find your top doctor',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Specialties horizontal list
            const Text(
              'Specialities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: specialties.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final speciality = specialties[index];
                  return GestureDetector(
                    onTap: () => onSpecialityTap(speciality),
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.teal),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        speciality,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.teal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Recent Doctors Section
            const Text(
              'Top Doctors',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),

            const SizedBox(height: 12),

            // Show up to 3 recent doctors
            recentDoctors.isEmpty
                ? const Center(child: Text('No doctors available'))
                : SizedBox(
                    height: 140,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: recentDoctors.length > 3
                          ? 3
                          : recentDoctors.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final doctor = recentDoctors[index];
                        return _DoctorCard(doctor: doctor);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

// Doctor card UI (similar to your doctor dashboard cards)
class _DoctorCard extends StatelessWidget {
  final DoctorEntity doctor;
  const _DoctorCard({required this.doctor});

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
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
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
