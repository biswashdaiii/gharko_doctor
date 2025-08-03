import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final Function(String) onSpecialityTap;

  Home({
    required this.onSpecialityTap,
    super.key,
  });

  final List<String> specialties = [
    'Gynecologist',
    'Dermatologist',
    'Neurologist',
    'General Physician',
  ];

  final Map<String, IconData> specialtyIcons = {
    'Gynecologist': Icons.pregnant_woman,
    'Dermatologist': Icons.health_and_safety,
    'Neurologist': Icons.psychology,
    'General Physician': Icons.medical_services,
  };

  final List<_FeatureItem> features = [
    _FeatureItem(
      icon: Icons.thumb_up_alt_outlined,
      title: 'Trusted Doctors',
      description: 'Experienced and verified professionals.',
    ),
    _FeatureItem(
      icon: Icons.schedule,
      title: 'Easy Booking',
      description: 'Book appointments in just a few taps.',
    ),
    _FeatureItem(
      icon: Icons.health_and_safety_outlined,
      title: 'Quality Care',
      description: 'Focused on your health and safety.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(  // <-- Added to enable scrolling
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top container with background image + overlay text
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: NetworkImage(
                      "http://192.168.1.77:5050/uploads/1753903624860-docc.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.2),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    "Welcome back!\nLet's find your top doctor",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Specialties horizontal list
              const Text(
                'Specialities',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 50,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: specialties.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final speciality = specialties[index];
                    return GestureDetector(
                      onTap: () => onSpecialityTap(speciality),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.teal.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.teal),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              specialtyIcons[speciality] ?? Icons.local_hospital,
                              color: Colors.teal,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              speciality,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.teal,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              // New Feature Section - Why Choose Us?
              const Text(
                'Why Choose Us?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: features.map((feature) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Icon(feature.icon, size: 42, color: Colors.teal),
                          const SizedBox(height: 12),
                          Text(
                            feature.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.teal,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            feature.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureItem {
  final IconData icon;
  final String title;
  final String description;

  _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}
