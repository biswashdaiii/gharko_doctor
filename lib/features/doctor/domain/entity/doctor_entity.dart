// lib/features/doctor/domain/entities/doctor_entity.dart

class DoctorEntity {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  final String speciality;
  final String degree;
  final String experience;
  final bool available;
  final int fee;
  final String about;
  final String date;
  final String address;

  DoctorEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.speciality,
    required this.degree,
    required this.experience,
    required this.available,
    required this.fee,
    required this.about,
    required this.date,
    required this.address,
  });
}
