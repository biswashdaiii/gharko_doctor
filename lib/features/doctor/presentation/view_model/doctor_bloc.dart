import 'package:bloc/bloc.dart';
import 'package:gharko_doctor/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:gharko_doctor/features/doctor/domain/usecase/get_all_doctor_usecase.dart';
import 'package:gharko_doctor/features/doctor/domain/usecase/get_doctor_byspeciality_usecase.dart';
import 'doctor_event.dart';
import 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final GetAllDoctorsUseCase getAllDoctorsUseCase;
  final GetDoctorsBySpecialityUseCase getDoctorsBySpecialityUseCase;

  DoctorBloc({
    required this.getAllDoctorsUseCase,
    required this.getDoctorsBySpecialityUseCase,
  }) : super(DoctorInitial()) {
    on<FetchAllDoctorsEvent>((event, emit) async {
      emit(DoctorLoading());

      final result = await getAllDoctorsUseCase();

      result.fold(
        (failure) => emit(DoctorError(_mapFailureToMessage(failure))),
        (doctors) => emit(DoctorLoaded(doctors)),
      );
    });

    on<FetchDoctorsBySpecialityEvent>((event, emit) async {
      emit(DoctorLoading());

      final result = await getDoctorsBySpecialityUseCase(event.speciality);

      result.fold(
        (failure) => emit(DoctorError(_mapFailureToMessage(failure))),
        (doctors) => emit(DoctorLoaded(doctors)),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message ?? 'Unexpected error occurred';
  }
}
