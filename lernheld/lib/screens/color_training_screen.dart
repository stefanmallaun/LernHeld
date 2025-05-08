import 'package:flutter/material.dart';
import 'dart:math';
import '../services/tts_service.dart';

class ColorTrainingScreen extends StatefulWidget {
  const ColorTrainingScreen({super.key});

  @override
  State<ColorTrainingScreen> createState() => _ColorTrainingScreenState();
}

class _ColorTrainingScreenState extends State<ColorTrainingScreen> {
  final TTSService tts = TTSService();
  bool isTestMode = false;

  final List<Map<String, dynamic>> colors = [
    {'name': 'Rot', 'color': Colors.red},
    {'name': 'Blau', 'color': Colors.blue},
    {'name': 'Grün', 'color': Colors.green},
    {'name': 'Gelb', 'color': Colors.yellow},
    {'name': 'Orange', 'color': Colors.orange},
    {'name': 'Lila', 'color': Colors.purple},
  ];

  late Map<String, dynamic> targetColor;

  @override
  void initState() {
    super.initState();
    _generateNewTarget();
  }

  void _generateNewTarget() {
    final rand = Random();
    targetColor = colors[rand.nextInt(colors.length)];
    if (isTestMode) {
      tts.speak("Welche Farbe ist ${targetColor['name']}?");
    }
  }

  void _checkColor(String selectedName) {
  if (selectedName == targetColor['name']) {
    tts.speak("Richtig!");
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _generateNewTarget(); // nur wenn korrekt
      });
    });
  } else {
    tts.speak("Leider falsch.");
    // keine neue Farbe, kein setState
  }
}

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('🎨 Farbtraining – Lernheld'),
    ),
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
              child: const Text('Farben üben'),
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
              child: const Text('Farben erkennen'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(child: isTestMode ? _buildTestMode() : _buildLearnMode()),
      ],
    ),
  );
}


  Widget _buildLearnMode() {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: colors.map((item) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: item['color']),
          onPressed: () => tts.speak(item['name']),
          child: Text(
            item['name'],
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
        ),

      );
      }).toList(),
    );
  }

  Widget _buildTestMode() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () => tts.speak("Welche Farbe ist ${targetColor['name']}?"),
        child: Column(
          children: [
            const Text(
              'Welche Farbe ist:',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black
              ),
            ),
            Text(
              targetColor['name'],
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: targetColor['color'],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
      Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: colors.map((item) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: item['color'],
              minimumSize: const Size(100, 100),
            ),
            onPressed: () => _checkColor(item['name']),
            child: const Text(''),
          );
        }).toList(),
      ),
    ],
  );
}
}

