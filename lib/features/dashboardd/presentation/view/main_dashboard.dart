import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gharko_doctor/features/authentication/presentation/view/signin_screen.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gharko_doctor/app/sharedPref/token_shared_pref.dart';
import 'package:gharko_doctor/core/network/auth_service.dart';
import 'package:gharko_doctor/features/chat/presentation/view/chatPage.dart';
import 'package:gharko_doctor/features/dashboardd/presentation/view/home.dart';
import 'package:gharko_doctor/features/doctor/presentation/view/doctor_page.dart';
import 'package:gharko_doctor/features/myappointments/presentation/view/myappointment_page.dart';
import 'package:gharko_doctor/features/profile/presentation/view/profile.dart';
 // Make sure this import is correct

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;
  String? selectedSpeciality;
  AuthService? authService;
  StreamSubscription? _accelerometerSubscription;
  DateTime? _lastShakeTime;

  @override
  void initState() {
    super.initState();
    _initAuthService();
    _startSensorListener();
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initAuthService() async {
    final prefs = await SharedPreferences.getInstance();
    final tokenPrefs = TokenSharedPrefs(sharedPreferences: prefs);
    authService = AuthService(tokenPrefs: tokenPrefs);
    setState(() {});
  }

  void _startSensorListener() {
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      double x = event.x;
      double y = event.y;
      double z = event.z;

      final gForce = sqrt(x * x + y * y + z * z);
      final now = DateTime.now();

      // Shake to logout
      if (gForce > 20) {
        if (_lastShakeTime == null || now.difference(_lastShakeTime!) > const Duration(seconds: 3)) {
          _lastShakeTime = now;
          _logout();
        }
      }

      // Tilt to switch tabs
      if (_selectedIndex == 2 && x < -6) {
        _switchTab(3); // Doctors → Appointments
      } else if (_selectedIndex == 3 && x > 6) {
        _switchTab(2); // Appointments → Doctors
      } else if (_selectedIndex == 4 && x < -6) {
        _switchTab(0); // Profile → Home
      }
    });
  }

  Future<void> _logout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (shouldLogout != true || authService == null) return;

    final result = await authService!.logout();

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logout failed: ${failure.message}')),
        );
      },
      (_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      },
    );
  }

  void _onSpecialitySelected(String speciality) {
    setState(() {
      _selectedIndex = 2;
      selectedSpeciality = speciality;
    });
  }

  void _switchTab(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
        if (index != 2) selectedSpeciality = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (authService == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final List<Widget> screens = [
      Home(onSpecialityTap: _onSpecialitySelected),
      ChatPage(chatUserId: '', chatUserName: ''),
      Dashboard(selectedSpeciality: selectedSpeciality ?? 'All'),
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
        onTap: _switchTab,
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
