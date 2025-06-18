import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';

class EducationalLessonsPage extends StatelessWidget {
  const EducationalLessonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> lessons = [
      {
        'title': 'First Aid',
        'lessons': 2,
        'icon': Icons.medical_services,
        'bgColor': const Color(0xFF84CC16),
      },
      {
        'title': 'CPR',
        'lessons': 5,
        'icon': Icons.favorite,
        'bgColor': const Color(0xFFE11D48),
      },
      {
        'title': 'Burn Treatment',
        'lessons': 10,
        'icon': Icons.local_fire_department,
        'bgColor': Colors.deepOrange,
      },
      {
        'title': 'Snake Bite',
        'lessons': 2,
        'icon': Icons.bug_report,
        'bgColor': Colors.green,
      },
      {
        'title': 'Fracture Care',
        'lessons': 4,
        'icon': Icons.accessibility_new,
        'bgColor': Colors.blueAccent,
      },
      {
        'title': 'Allergic Reaction',
        'lessons': 3,
        'icon': Icons.warning_amber,
        'bgColor': Colors.amber,
      },
      {
        'title': 'Heat Stroke',
        'lessons': 6,
        'icon': Icons.wb_sunny,
        'bgColor': Colors.orangeAccent,
      },
      {
        'title': 'Poisoning',
        'lessons': 3,
        'icon': Icons.science,
        'bgColor': Colors.purple,
      },
      {
        'title': 'Drowning Rescue',
        'lessons': 4,
        'icon': Icons.water,
        'bgColor': Colors.cyan,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFD9F99D)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Educational Lessons',
              style: TextStyle(
                fontSize: 22,
                color: Color(0xFFD9F99D),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'For yourself and your loved ones',
              style: TextStyle(fontSize: 12, color: Color(0xFFD9F99D)),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return Container(
            height: 100,
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2C),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: lesson['bgColor'],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    lesson['icon'],
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        lesson['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFFD9F99D),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${lesson['lessons']} Lessons',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFFD9F99D),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Color(0xFFD9F99D), size: 28),
              ],
            ),
          );
        },
      ),
    );
  }
}
