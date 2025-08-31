import 'package:flutter/material.dart';
import '../../../services/tts_service.dart';

class ColorLearnMode extends StatelessWidget {
  final List<Map<String, dynamic>> colors;
  final TTSService tts;

  const ColorLearnMode({
    required this.colors,
    required this.tts,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
        const spacing = 16.0;
        final totalSpacing = (crossAxisCount - 1) * spacing + 32;
        final itemWidth = (constraints.maxWidth - totalSpacing) / crossAxisCount;
        final rows = (colors.length / crossAxisCount).ceil();
        final totalHeight = constraints.maxHeight - 32;
        final itemHeight = (totalHeight - (rows - 1) * spacing - 32) / rows;
        final aspectRatio = itemWidth / itemHeight;

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: colors.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: aspectRatio,
          ),
          itemBuilder: (context, index) {
            final item = colors[index];
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: item['color'],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(12),
              ),
              onPressed: () => tts.speak(item['name']),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.volume_up, size: 28, color: Colors.black87),
                  const SizedBox(height: 8),
                  Text(
                    item['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: itemWidth * 0.1,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
