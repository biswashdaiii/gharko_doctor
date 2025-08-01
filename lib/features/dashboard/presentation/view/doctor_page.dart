import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/features/booking/presentation/view/appointment_page.dart';
import 'package:gharko_doctor/features/dashboard/domain/entity/doctor_entity.dart';
import 'package:gharko_doctor/features/dashboard/presentation/view_model/doctor_bloc.dart';
import 'package:gharko_doctor/features/dashboard/presentation/view_model/doctor_event.dart';
import 'package:gharko_doctor/features/dashboard/presentation/view_model/doctor_state.dart';
import 'package:gharko_doctor/app/service_locator/service_locator.dart';
import 'package:gharko_doctor/features/dashboard/domain/usecase/get_all_doctor_usecase.dart';
import 'package:gharko_doctor/features/dashboard/domain/usecase/get_doctor_byspeciality_usecase.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required String selectedSpeciality});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Add specialties including "All"
  final List<String> specialties = [
    'All',
    'General Physician',
    'Gynecologist',
    'Dermatologist',
    'Neurologist',
  ];

  String selectedSpeciality = 'All';

  late DoctorBloc doctorBloc;

  List<DoctorEntity> allDoctors = [];

  @override
  void initState() {
    super.initState();

    doctorBloc = DoctorBloc(
      getAllDoctorsUseCase: serviceLocator<GetAllDoctorsUseCase>(),
      getDoctorsBySpecialityUseCase:
          serviceLocator<GetDoctorsBySpecialityUseCase>(),
    );

    // Fetch all doctors at start
    doctorBloc.add(FetchAllDoctorsEvent());
  }

  @override
  void dispose() {
    doctorBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: doctorBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Find Your Related Doctor',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          backgroundColor: Colors.teal,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Available Doctors',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 16),

              // Specialty filter as horizontal buttons
              SizedBox(
                height: 45,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: specialties.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final speciality = specialties[index];
                    final bool isSelected = speciality == selectedSpeciality;

                    return ChoiceChip(
                      label: Text(
                        speciality,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          selectedSpeciality = speciality;
                        });
                      },
                      selectedColor: Colors.teal,
                      backgroundColor: Colors.grey.shade200,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: BlocBuilder<DoctorBloc, DoctorState>(
                  builder: (context, state) {
                    if (state is DoctorLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is DoctorLoaded) {
                      allDoctors = state.doctors;

                      List<DoctorEntity> filteredDoctors =
                          selectedSpeciality == 'All'
                              ? allDoctors
                              : allDoctors
                                  .where(
                                    (d) =>
                                        d.speciality.toLowerCase() ==
                                        selectedSpeciality.toLowerCase(),
                                  )
                                  .toList();

                      final recentDoctors =
                          filteredDoctors.length > 10
                              ? filteredDoctors.sublist(0, 3)
                              : filteredDoctors;

                      if (recentDoctors.isEmpty) {
                        return const Center(
                          child: Text(
                            'No doctors available',
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      }

                      return ListView.separated(
                        itemCount: recentDoctors.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final doctor = recentDoctors[index];
                          return Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.teal.shade50,
                                backgroundImage:
                                    doctor.imageUrl.isNotEmpty
                                        ? NetworkImage(
                                          'http://192.168.1.77:5050/${doctor.imageUrl}',
                                        )
                                        : null,
                                child:
                                    doctor.imageUrl.isEmpty
                                        ? Text(
                                          doctor.name.isNotEmpty
                                              ? doctor.name[0]
                                              : '',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.teal,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                        : null,
                              ),
                              title: Text(
                                doctor.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Text(
                                '${doctor.speciality} · ${doctor.degree}',
                                style: const TextStyle(fontSize: 13),
                              ),
                              trailing: Text(
                                '\$${doctor.fee}',
                                style: const TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => AppointmentPage(
                                          doctorId: doctor.id,
                                          doctorName: doctor.name,
                                          specialty: doctor.speciality,
                                          about:
                                              doctor.about ??
                                              "No details available",
                                          fee: doctor.fee.toDouble(),
                                          experienceYears: 0,
                                          doctorImageUrl:
                                              'http://192.168.1.77:5050/${doctor.imageUrl}',
                                        ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    } else if (state is DoctorError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
