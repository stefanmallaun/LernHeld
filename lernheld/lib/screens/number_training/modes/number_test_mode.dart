import 'package:flutter/material.dart';
import '../../../services/tts_service.dart';

class NumberTestMode extends StatelessWidget {
  final List<int> numbers;
  final int targetNumber;
  final Function(int) onSelect;
  final String Function(int) numberToWord;
  final TTSService tts;

  const NumberTestMode({
    super.key,
    required this.numbers,
    required this.targetNumber,
    required this.onSelect,
    required this.numberToWord,
    required this.tts,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 4 : 3;
        final spacing = 16.0;
        final totalSpacing = (crossAxisCount - 1) * spacing + 32;
        final itemWidth = (constraints.maxWidth - totalSpacing) / crossAxisCount;
        final rows = (numbers.length / crossAxisCount).ceil();
        final totalHeight = constraints.maxHeight - 160; // Platz für Frage oben
        final itemHeight = (totalHeight - (rows - 1) * spacing - 32) / rows;
        final aspectRatio = itemWidth / itemHeight;

        return Column(
          children: [
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => tts.speak("Welche Zahl ist ${numberToWord(targetNumber)}?"),
              child: Column(
                children: [
                  const Text(
                    'Welche Zahl ist:',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    numberToWord(targetNumber),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  childAspectRatio: aspectRatio,
                ),
                itemCount: numbers.length,
                itemBuilder: (context, index) {
                  final number = numbers[index];
                  return ElevatedButton(
                    onPressed: () => onSelect(number),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      '$number',
                      style: const TextStyle(fontSize: 32),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
