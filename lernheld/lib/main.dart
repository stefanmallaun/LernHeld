import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/color_training/color_training_screen.dart';
import 'screens/number_training/number_training_screen.dart';

void main() {
  runApp(const LernHeldApp());
}

class LernHeldApp extends StatelessWidget {
  const LernHeldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FörderHeld',
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/color': (context) => const ColorTrainingScreen(),
        '/number': (context) => const NumberTrainingScreen(),
      },
    );
  }
}
