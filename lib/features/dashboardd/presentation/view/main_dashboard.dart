import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gharko_doctor/core/network/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gharko_doctor/features/doctor/domain/entity/doctor_entity.dart';
import 'package:gharko_doctor/features/doctor/presentation/view/doctor_page.dart';
import 'package:gharko_doctor/features/myappointments/presentation/view/myappointment_page.dart';
import 'package:gharko_doctor/features/profile/presentation/view/profile.dart';
import 'package:gharko_doctor/screens/view/search.dart';
import 'package:gharko_doctor/features/dashboardd/presentation/view/home.dart';
import 'package:gharko_doctor/app/sharedPref/token_shared_pref.dart';


class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;
  String? selectedSpeciality;
  List<DoctorEntity> recentDoctors = [];

  AuthService? authService;

  @override
  void initState() {
    super.initState();
    _initAuthService();
  }

  Future<void> _initAuthService() async {
    final prefs = await SharedPreferences.getInstance();
    final tokenPrefs = TokenSharedPrefs(sharedPreferences: prefs);
    authService = AuthService(tokenPrefs: tokenPrefs);
    setState(() {}); // rebuild now that authService is ready
  }

  void _onSpecialitySelected(String speciality) {
    setState(() {
      _selectedIndex = 2; // Navigate to doctor tab
      selectedSpeciality = speciality;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (authService == null) {
      // Show loading until authService initialized
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final List<Widget> screens = [
      Home(
        onSpecialityTap: _onSpecialitySelected,
      
      ),
      const Search(),
      Dashboard(
        selectedSpeciality: selectedSpeciality ?? 'All',
      ),
      const MyAppointmentsPage(),
      ProfilePage(
        userId: '68720835b6b37497fca02836',
        authService: authService!,
      ),
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
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.chartBar), label: 'Chat'),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.stethoscope), label: 'Doctors'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Appointments'),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.user), label: 'Profile'),
        ],
      ),
    );
  }
}
