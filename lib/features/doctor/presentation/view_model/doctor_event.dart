import 'package:equatable/equatable.dart';

abstract class DoctorEvent extends Equatable {
  const DoctorEvent();

  @override
  List<Object?> get props => [];
}

/// Event to fetch all doctors
class FetchAllDoctorsEvent extends DoctorEvent {}

/// Event to fetch doctors by speciality
class FetchDoctorsBySpecialityEvent extends DoctorEvent {
  final String speciality;

  const FetchDoctorsBySpecialityEvent(this.speciality);

  @override
  List<Object?> get props => [speciality];
}
/// Event to search doctors by name
class SearchDoctorsByNameEvent extends DoctorEvent {
  final String name;

  const SearchDoctorsByNameEvent(this.name);

  @override
  List<Object?> get props => [name];
} 