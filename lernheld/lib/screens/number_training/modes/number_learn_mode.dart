import 'package:flutter/material.dart';
import '../../../services/tts_service.dart';

class NumberLearnMode extends StatelessWidget {
  final List<int> numbers;
  final TTSService tts;

  const NumberLearnMode({
    super.key,
    required this.numbers,
    required this.tts,
  });

  Color _getColor(int index) {
    final colors = [
      Colors.lightBlue.shade100,
      Colors.greenAccent.shade100,
      Colors.orangeAccent.shade100,
      Colors.pink.shade100,
      Colors.amber.shade100,
      Colors.tealAccent.shade100,
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 4 : 3;
        const spacing = 16.0;
        final totalSpacing = (crossAxisCount - 1) * spacing + 32; // + padding
        final itemWidth = (constraints.maxWidth - totalSpacing) / crossAxisCount;
        final rows = (numbers.length / crossAxisCount).ceil();
        final totalHeight = constraints.maxHeight - (rows - 1) * spacing - 32;
        final itemHeight = totalHeight / rows;
        final aspectRatio = itemWidth / itemHeight;

        return GridView.builder(
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
              onPressed: () => tts.speak(number.toString()),
              style: ElevatedButton.styleFrom(
                backgroundColor: _getColor(index),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.volume_up, size: 28, color: Colors.black87),
                  const SizedBox(height: 8),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '$number',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
