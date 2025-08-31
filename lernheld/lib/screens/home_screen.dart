import 'package:flutter/material.dart';
import 'package:lernheld/services/UserControl.dart';
import 'package:lernheld/screens/UserControll_screen.dart/profile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = UserController(); // Singleton
    final bool isLoggedIn = userController.isLoggedIn();

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎓 LernHeld'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isLoggedIn ? Icons.person : Icons.login),
            tooltip: isLoggedIn ? "Profil" : "Login",
            onPressed: () {
              if (isLoggedIn) {
                Navigator.pushReplacementNamed(context, '/profile', arguments: userController.getCurrentUserEmail());
              } else {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Willkommen bei LernHeld!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildHomeButton(
              context: context,
              icon: Icons.color_lens,
              label: 'Farbtraining',
              route: '/color',
              color: Colors.deepPurpleAccent,
            ),
            const SizedBox(height: 20),
            _buildHomeButton(
              context: context,
              icon: Icons.calculate,
              label: 'Zahlentraining',
              route: '/number',
              color: Colors.teal,
            ),
            const SizedBox(height: 20),
            _buildHomeButton(
              context: context,
              icon: Icons.abc_outlined,
              label: 'Buchstabentraining',
              route: '/letter',
              color: const Color.fromARGB(255, 0, 150, 0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String route,
    required Color color,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ElevatedButton.icon(
        onPressed: () => Navigator.pushNamed(context, route),
        icon: Icon(icon, size: 32),
        label: Text(
          label,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 5,
        ),
      ),
    );
  }
}
