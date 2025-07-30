
import 'package:gharko_doctor/features/dashboard/domain/entity/doctor_entity.dart';

abstract interface class IDoctorDataSource {
  Future<List<DoctorEntity>> getAllDoctors();
  Future<List<DoctorEntity>> getDoctorsBySpeciality(String speciality);
}
