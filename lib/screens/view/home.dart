import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Container
              Container(
                height: 300,
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 4, 141, 127),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome back!",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 50),
                    const Text(
                      "Let’s find  ",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      " your Top doctor",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 50),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Search...",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 0),
                        suffixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // Specialities Label
              const Text(
                "Specialities ",
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 20),
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    // Dentist
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 224, 248, 246),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.tooth,
                              color: Colors.teal,
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          "Dentist",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),

                    // Cardiologist
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 224, 248, 246),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.heartPulse,
                              color: Colors.teal,
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          "Cardiologist",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),

                    // Pulmonologist
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 224, 248, 246),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.lungs,
                              color: Colors.teal,
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          "Pulmonologist",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),

                    // Physiotherapy
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 224, 248, 246),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.personWalkingWithCane,
                              color: Colors.teal,
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          "Physiotherapy",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                "Recent",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Doctor List
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 224, 248, 246),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/images/2.jpg',
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Dr. Ram Bahadur Thapa',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Heart Surgeon',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Bir Hospital',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 224, 248, 246),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/images/1.jpg',
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Dr. Rita Thapa Magar',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Dentist',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Teaching Hospital',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
