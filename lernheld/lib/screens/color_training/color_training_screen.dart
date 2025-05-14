import 'package:flutter/material.dart';
import 'dart:math';
import 'modes/color_learn_mode.dart';
import 'modes/color_test_mode.dart';
import '../../services/tts_service.dart';

class ColorTrainingScreen extends StatefulWidget {
  const ColorTrainingScreen({super.key});

  @override
  State<ColorTrainingScreen> createState() => _ColorTrainingScreenState();
}

class _ColorTrainingScreenState extends State<ColorTrainingScreen> {
  final TTSService tts = TTSService();
  bool isTestMode = false;
  int colorCount = 6;

  final List<Map<String, dynamic>> colors = [
    {'name': 'Rot', 'color': Colors.red},
    {'name': 'Blau', 'color': Colors.blue},
    {'name': 'Grün', 'color': Colors.green},
    {'name': 'Gelb', 'color': Colors.yellow},
    {'name': 'Orange', 'color': Colors.orange},
    {'name': 'Lila', 'color': Colors.purple},
  ];

  late Map<String, dynamic> targetColor;
  Color backgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _generateNewTarget();
  }

  void _generateNewTarget() {
    final rand = Random();
    final currentColors = colors.take(colorCount).toList();
    if (currentColors.isEmpty) return;

    targetColor = currentColors[rand.nextInt(currentColors.length)];
    if (isTestMode) {
      tts.speak("Welche Farbe ist ${targetColor['name']}?");
    }
  }

  void _checkColor(String selectedName) {
    if (selectedName == targetColor['name']) {
      setState(() {
        backgroundColor = Colors.green;
      });

      tts.speak("Richtig!");
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          backgroundColor = Colors.white;
          _generateNewTarget();
        });
      });
    } else {
      tts.speak("Leider falsch.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎨 Farbtraining – Lernheld'),
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: backgroundColor,
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        !isTestMode ? Colors.blue : Colors.grey[300],
                    foregroundColor:
                        !isTestMode ? Colors.white : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      isTestMode = false;
                      backgroundColor = Colors.white;
                    });
                  },
                  child: const Text('Farben üben'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isTestMode ? Colors.blue : Colors.grey[300],
                    foregroundColor:
                        isTestMode ? Colors.white : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      isTestMode = true;
                      backgroundColor = Colors.white;
                      _generateNewTarget();
                    });
                  },
                  child: const Text('Farben erkennen'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: isTestMode
                  ? ColorTestMode(
                      colors: colors.take(colorCount).toList(),
                      targetColor: targetColor,
                      onSelect: _checkColor,
                      tts: tts,
                    )
                  : ColorLearnMode(
                      colors: colors.take(colorCount).toList(),
                      tts: tts,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Anzahl der Farben:'),
                  Slider(
                    value: colorCount.toDouble(),
                    min: 2,
                    max: colors.length.toDouble(),
                    divisions: colors.length - 2,
                    label: '$colorCount',
                    onChanged: (value) {
                      setState(() {
                        colorCount = value.toInt();
                        if (isTestMode) _generateNewTarget();
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
