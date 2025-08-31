import 'package:flutter/material.dart';
import 'package:lernheld/services/UserControl.dart';

class ProfilePage extends StatelessWidget {
  final String userEmail;
  final UserController userController = UserController();

  ProfilePage({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    final userName = userController.getCurrentUserEmail() ?? 'Benutzer';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              userController.logout(); // Logout ausführen
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',  // Home-Screen
                (route) => false, // alle vorherigen Seiten entfernen
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Willkommen, $userName!',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Hier kannst du dein Profil und deine Trainings starten.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/color'); 
                },
                child: const Text('Farbtraining starten'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
