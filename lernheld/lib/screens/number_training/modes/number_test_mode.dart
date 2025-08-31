import 'package:flutter/material.dart';
import '../../../services/tts_service.dart';

class NumberTestMode extends StatefulWidget {
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
  State<NumberTestMode> createState() => _NumberTestModeState();
}

class _NumberTestModeState extends State<NumberTestMode> {
  // Eine Liste, um die Farben der einzelnen Buttons zu verfolgen
  List<Color> _buttonColors = [];

  @override
  void initState() {
    super.initState();
    // Initialisieren der Farben der Buttons (freundliche Farbe für alle)
    _buttonColors = List.generate(widget.numbers.length, (index) => const Color.fromARGB(255, 194, 193, 193)); 
  }

  void _handleAnswer(int selected) {
    final selectedIndex = widget.numbers.indexOf(selected);

    setState(() {
      // Wenn die Antwort richtig ist, setze die Farbe auf grün, ansonsten rot
      if (selected == widget.targetNumber) {
        _buttonColors[selectedIndex] = Colors.green; // Richtige Antwort
      } else {
        _buttonColors[selectedIndex] = Colors.red; // Falsche Antwort
      }
    });

    // Call the parent function to handle the logic
    widget.onSelect(selected);

    // Setze die Farben nach 1 Sekunde zurück
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        // Setze alle Farben auf die freundliche Farbe zurück
        _buttonColors = List.generate(widget.numbers.length, (index) => const Color.fromARGB(255, 194, 193, 193));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 4 : 3;
        const spacing = 16.0;
        final totalSpacing = (crossAxisCount - 1) * spacing + 32;
        final itemWidth = (constraints.maxWidth - totalSpacing) / crossAxisCount;
        final rows = (widget.numbers.length / crossAxisCount).ceil();
        final totalHeight = constraints.maxHeight - 160; // Platz für Frage oben
        final itemHeight = (totalHeight - (rows - 1) * spacing - 32) / rows;
        final aspectRatio = itemWidth / itemHeight;

        return Column(
          children: [
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => widget.tts.speak("Welche Zahl ist ${widget.numberToWord(widget.targetNumber)}?"),
              child: Column(
                children: [
                  const Text(
                    'Welche Zahl ist:',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    widget.numberToWord(widget.targetNumber),
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
                itemCount: widget.numbers.length,
                itemBuilder: (context, index) {
                  final number = widget.numbers[index];
                  return ElevatedButton(
                    onPressed: () => _handleAnswer(number),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: _buttonColors[index], // Setze die Farbe für die ausgewählte Zahl
                    ),
                    child: Text(
                      '$number',
                      style: const TextStyle(fontSize: 32, color: Colors.black),
                            
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
