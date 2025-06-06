import 'package:flutter/material.dart';
import 'letter_tracing_screen.dart'; // make sure this import path is correct

class LetterTrainingScreen extends StatelessWidget {
  const LetterTrainingScreen({super.key});

  final List<String> letters = const ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buchstabentraining')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: letters.length,
        itemBuilder: (context, index) {
          final letter = letters[index];
          return ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LetterTracingScreen(letter: letter),
                ),
              );
            },
            child: Text(
              letter,
              style: const TextStyle(fontSize: 32),
            ),
          );
        },
      ),
    );
  }
}
