import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gharko_doctor/features/dashboard/domain/entity/doctor_entity.dart';
import 'package:gharko_doctor/features/dashboard/presentation/view/doctor_page.dart';
import 'package:gharko_doctor/features/profile/presentation/view/profile.dart';
import 'package:gharko_doctor/screens/view/search.dart';
import 'package:gharko_doctor/features/dashboard/presentation/view/home.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;
  String? selectedSpeciality;

  // Temporary empty list; update with real data later
  List<DoctorEntity> recentDoctors = [];

  void _onSpecialitySelected(String speciality) {
    setState(() {
      _selectedIndex = 2; // Navigate to doctor tab
      selectedSpeciality = speciality;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      Home(
        onSpecialityTap: _onSpecialitySelected,
        recentDoctors: recentDoctors,
      ),
      const Search(),
      Dashboard(
        selectedSpeciality: selectedSpeciality ?? 'All',
      ),

      const ProfilePage(userId: '',),
    ];

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey.shade600,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            if (index != 2) {
              selectedSpeciality = null;
            }
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.chartBar), label: 'chat'),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.stethoscope), label: 'Doctors'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Appointments'),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.user), label: 'Profile'),
        ],
      ),
    );
  }
}
