import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Dummy list of doctors for the list view
  final List<Map<String, String>> doctors = [
    {
      'name': 'Dr. John Doe',
      'speciality': 'Dentist',
      'image': 'https://randomuser.me/api/portraits/men/1.jpg'
    },
    {
      'name': 'Dr. Jane Smith',
      'speciality': 'Cardiologist',
      'image': 'https://randomuser.me/api/portraits/women/2.jpg'
    },
    {
      'name': 'Dr. Mike Johnson',
      'speciality': 'Neurologist',
      'image': 'https://randomuser.me/api/portraits/men/3.jpg'
    },
    {
      'name': 'Dr. Emily Davis',
      'speciality': 'Dermatologist',
      'image': 'https://randomuser.me/api/portraits/women/4.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bigger Welcome Container
              Container(
                height: 260,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 7, 221, 200),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome back!",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Let’s find your top doctor",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Search...",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        suffixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Specialities Label
              const Text(
                "Specialities most relevant to you",
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    specialityIcon(FontAwesomeIcons.tooth, "Dentist"),
                    const SizedBox(width: 16),
                    specialityIcon(FontAwesomeIcons.heartPulse, "Cardiologist"),
                    const SizedBox(width: 16),
                    specialityIcon(FontAwesomeIcons.lungs, "Pulmonologist"),
                    const SizedBox(width: 16),
                    specialityIcon(FontAwesomeIcons.personWalkingWithCane, "Physiotherapy"),
                    const SizedBox(width: 16),
                    specialityIcon(FontAwesomeIcons.brain, "Neurologist"),
                    const SizedBox(width: 16),
                    specialityIcon(FontAwesomeIcons.spa, "Dermatologist"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Doctors List Label
              const Text(
                "Available Doctors",
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 10),

              // Expanded ListView of Doctors
              Expanded(
                child: ListView.builder(
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doc = doctors[index];
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(doc['image']!),
                        ),
                        title: Text(doc['name']!),
                        subtitle: Text(doc['speciality']!),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // You can add doctor details navigation here later
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget specialityIcon(IconData iconData, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 224, 248, 246),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: FaIcon(
              iconData,
              color: const Color.fromARGB(255, 7, 221, 200),
              size: 30,
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
