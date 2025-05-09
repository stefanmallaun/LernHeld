import 'package:flutter/material.dart';
import 'dart:math';
import '../../services/tts_service.dart';
import 'modes/number_learn_mode.dart';
import 'modes/number_test_mode.dart';

class NumberTrainingScreen extends StatefulWidget {
  const NumberTrainingScreen({super.key});

  @override
  State<NumberTrainingScreen> createState() => _NumberTrainingScreenState();
}

class _NumberTrainingScreenState extends State<NumberTrainingScreen> {
  final TTSService tts = TTSService();
  bool isTestMode = false;
  int numberCount = 10;

  final List<int> numbers = List.generate(10, (i) => i); // 0–9
  late int targetNumber;

  @override
  void initState() {
    super.initState();
    _generateNewTarget();
  }

  void _generateNewTarget() {
    final rand = Random();
    final currentNumbers = numbers.take(numberCount).toList();
    targetNumber = currentNumbers[rand.nextInt(currentNumbers.length)];
    if (isTestMode) {
      tts.speak("Welche Zahl ist ${_numberToWord(targetNumber)}?");
    }
  }

  void _checkAnswer(int selected) {
    if (selected == targetNumber) {
      tts.speak("Richtig!");
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _generateNewTarget();
        });
      });
    } else {
      tts.speak("Leider falsch.");
    }
  }

  String _numberToWord(int number) {
    const words = [
      'Null', 'Eins', 'Zwei', 'Drei', 'Vier',
      'Fünf', 'Sechs', 'Sieben', 'Acht', 'Neun'
    ];
    return words[number];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🔢 Zahlentraining')),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: !isTestMode ? Colors.blue : Colors.grey[300],
                  foregroundColor: !isTestMode ? Colors.white : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    isTestMode = false;
                  });
                },
                child: const Text('Zahlen üben'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isTestMode ? Colors.blue : Colors.grey[300],
                  foregroundColor: isTestMode ? Colors.white : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    isTestMode = true;
                    _generateNewTarget();
                  });
                },
                child: const Text('Zahlen erkennen'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: isTestMode
                ? NumberTestMode(
                    numbers: numbers.take(numberCount).toList(),
                    targetNumber: targetNumber,
                    onSelect: _checkAnswer,
                    numberToWord: _numberToWord,
                    tts: tts,
                  )
                : NumberLearnMode(
                    numbers: numbers.take(numberCount).toList(),
                    tts: tts,
                  ),
          ),
        ],
      ),
    );
  }
}
