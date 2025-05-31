
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gharko_doctor/screens/view/appointment.dart';
import 'package:gharko_doctor/screens/view/doctor.dart';
import 'package:gharko_doctor/screens/view/home.dart';
import 'package:gharko_doctor/screens/view/profile.dart';
import 'package:gharko_doctor/screens/view/search.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedindex=0;
  List<Widget>lstscreens=[
    const home(),
    const Search(),
    const Doctor(),
    const Appointment(),
    const Profile()

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: lstscreens[_selectedindex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon:Icon(Icons.home),
            label: "home",
            
            
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.search),
            label: "Search"
          ),
          BottomNavigationBarItem(
            icon:FaIcon(FontAwesomeIcons.stethoscope),//to use icons form fontawesomw icons i have to add dependencises on puspec.ymal
            label: "doctors"
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.calendar_today),
            label: "Appointments"
          ),
          BottomNavigationBarItem(
            icon:FaIcon(FontAwesomeIcons.user),//to use icons form fontawesomw icons i have to add dependencises on puspec.ymal
            label: "profile"
          ),
         
        ],
        backgroundColor: const Color.fromARGB(255, 217, 252, 234),
        selectedItemColor: Colors.teal,
        unselectedItemColor: const Color.fromARGB(255, 240, 229, 229),
        currentIndex: _selectedindex,
        onTap: (index){
          setState(() {
            _selectedindex=index;
          });
        }
      ),
    );
  }
}