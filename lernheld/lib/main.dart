import 'package:flutter/material.dart';
import 'package:lernheld/screens/UserControll_screen.dart/login.dart';
import 'package:lernheld/screens/UserControll_screen.dart/profile.dart';
import 'package:lernheld/screens/UserControll_screen.dart/register.dart';
import 'package:lernheld/screens/letter_training/letter_training_screen.dart';
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
        '/letter': (context) => const LetterTrainingScreen(),
        '/login': (context) => LoginPage(), 
        '/register': (context) => RegisterPage(),
        
      },
      onGenerateRoute: (settings) {
      if (settings.name == '/profile') {
      final email = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => ProfilePage(userEmail: email),
      );
    }
    return null; 
      }
    );
  }
}
