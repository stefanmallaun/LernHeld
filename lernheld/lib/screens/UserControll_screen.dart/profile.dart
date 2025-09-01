// File: lib/pages/profile_page.dart
import 'package:flutter/material.dart';
import 'package:lernheld/services/UserControl.dart';
import 'package:lernheld/widgets/training_pie_chart.dart';
import 'dart:math';

class ProfilePage extends StatelessWidget {
  final String userEmail;
  final UserController userController = UserController();

  ProfilePage({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    final userName = userController.getCurrentUserEmail() ?? 'Benutzer';
    final random = Random();

    // Random Demo-Werte für die drei Trainings
    final letterData = [random.nextDouble() * 40 + 10, random.nextDouble() * 30 + 10, random.nextDouble() * 20 + 10];
    final colorData = [random.nextDouble() * 50 + 10, random.nextDouble() * 20 + 10, random.nextDouble() * 30 + 10];
    final numberData = [random.nextDouble() * 25 + 10, random.nextDouble() * 35 + 10, random.nextDouble() * 40 + 10];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home),
          tooltip: 'Home',
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/', // Home-Screen Route
              (route) => false,
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              userController.logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_placeholder.png'),
            ),

            const SizedBox(height: 16),

            Text(
              userName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),
            const Divider(thickness: 1),
            const SizedBox(height: 20),

            const Text(
              "Deine Statistiken",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // Top row: Letter + Color Training
            Row(
              children: [
                Expanded(
                  child: TrainingPieChart(
                    title: "Letter Training",
                    data: letterData,
                    colors: [Colors.blue, Colors.red, Colors.green],
                    small: true,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TrainingPieChart(
                    title: "Color Training",
                    data: colorData,
                    colors: [Colors.orange, Colors.purple, Colors.teal],
                    small: true,
                  ),
                ),
              ],
            ),

            // Bottom: Number Training
            TrainingPieChart(
              title: "Number Training",
              data: numberData,
              colors: [Colors.cyan, Colors.pink, Colors.amber],
              small: true,
            ),
          ],
        ),
      ),
    );
  }
}
