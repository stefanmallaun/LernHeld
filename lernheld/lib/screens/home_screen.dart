import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎓 LernHeld'),
        centerTitle: true,
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
