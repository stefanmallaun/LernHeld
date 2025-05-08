import 'package:flutter/material.dart';
import '../services/tts_service.dart';
import 'dart:math';

class NumberTrainingScreen extends StatefulWidget {
  const NumberTrainingScreen({super.key});

  @override
  State<NumberTrainingScreen> createState() => _NumberTrainingScreenState();
}

class _NumberTrainingScreenState extends State<NumberTrainingScreen> {
  final tts = TTSService();
  late int correctNumber;
  late List<int> options;

  @override
  void initState() {
    super.initState();
    _generateNewTask();
  }

  void _generateNewTask() {
    final rand = Random();
    correctNumber = rand.nextInt(5) + 1;
    options = List.generate(3, (_) => rand.nextInt(5) + 1);
    if (!options.contains(correctNumber)) {
      options[rand.nextInt(3)] = correctNumber;
    }
    setState(() {});
    tts.speak("Welche Zahl ist $correctNumber?");
  }

  void _checkAnswer(int selected) {
    if (selected == correctNumber) {
      tts.speak("Richtig!");
    } else {
      tts.speak("Leider falsch.");
    }
    Future.delayed(const Duration(seconds: 2), _generateNewTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🔢 Zahlentraining')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: options
              .map(
                (num) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => _checkAnswer(num),
                    child: Text(
                      '$num',
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
