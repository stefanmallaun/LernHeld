import 'package:flutter/material.dart';
import '../../../services/tts_service.dart';

class ColorTestMode extends StatelessWidget {
  final List<Map<String, dynamic>> colors;
  final Map<String, dynamic> targetColor;
  final void Function(String) onSelect;
  final TTSService tts;

  const ColorTestMode({
    required this.colors,
    required this.targetColor,
    required this.onSelect,
    required this.tts,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
        final spacing = 16.0;
        final totalSpacing = (crossAxisCount - 1) * spacing + 32;
        final itemWidth = (constraints.maxWidth - totalSpacing) / crossAxisCount;
        final rows = (colors.length / crossAxisCount).ceil();
        final totalHeight = constraints.maxHeight - 220; // space for header
        final itemHeight = (totalHeight - (rows - 1) * spacing) / rows;
        final aspectRatio = itemWidth / itemHeight;

        return Column(
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => tts.speak("Welche Farbe ist ${targetColor['name']}?"),
              child: Column(
                children: [
                  const Text('Welche Farbe ist:', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 4),
                  Text(
                    targetColor['name'],
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: targetColor['color'],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Icon(Icons.volume_up, size: 30, color: Colors.black54),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
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
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                    ),
                    onPressed: () => onSelect(item['name']),
                    child: const SizedBox.shrink(), // nur farbiger Button ohne Text
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
