import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C2D),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB47B48),
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 24),
            const Text(
              'Your Name',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'your.email@example.com',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFB47B48),
                minimumSize: Size(140, 44),
              ),
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
              onPressed: () {
                // Add edit profile functionality here
              },
            ),
          ],
        ),
      ),
    );
  }
} 