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
        appBar: AppBar(title: const Text('Find Your Related Doctor')),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Doctors',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Specialty filter as horizontal buttons
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: specialties.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final speciality = specialties[index];
                    final bool isSelected = speciality == selectedSpeciality;

                    return ChoiceChip(
                      label: Text(speciality),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          selectedSpeciality = speciality;
                        });
                      },
                      selectedColor: Colors.teal,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: BlocBuilder<DoctorBloc, DoctorState>(
                  builder: (context, state) {
                    if (state is DoctorLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is DoctorLoaded) {
                      allDoctors = state.doctors;

                      // Filter doctors by selected speciality if not "All"
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

                      // Show max 3 doctors only (recent 3)
                      final recentDoctors =
                          filteredDoctors.length > 10
                              ? filteredDoctors.sublist(0, 3)
                              : filteredDoctors;

                      if (recentDoctors.isEmpty) {
                        return const Center(
                          child: Text('No doctors available'),
                        );
                      }

                      return ListView.separated(
                        itemCount: recentDoctors.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final doctor = recentDoctors[index];
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey.shade200,
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
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                      : null,
                            ),

                            title: Text(doctor.name),
                            subtitle: Text(
                              '${doctor.speciality} - ${doctor.degree}',
                            ),
                            trailing: Text('\$${doctor.fee}'),
                            onTap: () {
                              final docData = {
                                'id': doctor.id,
                                'name': doctor.name,
                                'speciality': doctor.speciality,
                                'degree': doctor.degree,
                                'about': doctor.about ?? "No details available",
                                'fee': doctor.fee,
                                'imageUrl': doctor.imageUrl,
                              };

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
                                        // ✅ Required argument
                                      ),
                                ),
                              );
                            },
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
