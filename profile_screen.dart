import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget buildGoalTile(
    IconData icon,
    String text,
  ) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),

      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.teal,
        ),

        title: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.teal,

              child: Text(
                'AB',

                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Awah Blaise',

              style: TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Student ID: LMUI-24SWE282',

              style: TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Software Engineering Department',

              style: TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 25),

            Card(
              elevation: 4,

              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                        15),
              ),

              child: const Padding(
                padding:
                    EdgeInsets.all(16),

                child: Text(
                  'I am a passionate software engineering student who enjoys developing mobile applications and solving real-world problems using technology. I enjoy Flutter development, UI design, and learning modern software engineering practices.',

                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Align(
              alignment:
                  Alignment.centerLeft,

              child: Text(
                'Top Goals This Semester',

                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            buildGoalTile(
              Icons.school,
              'Pass all courses with excellent grades',
            ),

            buildGoalTile(
              Icons.code,
              'Master Flutter mobile development',
            ),

            buildGoalTile(
              Icons.work,
              'Build a professional software portfolio',
            ),
          ],
        ),
      ),
    );
  }
}
