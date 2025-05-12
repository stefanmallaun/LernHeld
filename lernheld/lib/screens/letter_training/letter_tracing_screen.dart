import 'package:flutter/material.dart';

class LetterTracingScreen extends StatefulWidget {
  final String letter;

  const LetterTracingScreen({super.key, required this.letter});

  @override
  State<LetterTracingScreen> createState() => _LetterTracingScreenState();
}

class _LetterTracingScreenState extends State<LetterTracingScreen> {
  List<Offset> points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buchstabe: ${widget.letter}')),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Spure den Buchstaben nach:',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Expanded(
          child: Stack(
            children: [
              Center(
                child: Text(
                  widget.letter,
                  style: TextStyle(
                    fontSize: 280,
                    color: Colors.grey.shade300,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned.fill(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return GestureDetector(
                      onPanUpdate: (details) {
                        RenderBox renderBox = context.findRenderObject() as RenderBox;
                        Offset localPosition = renderBox.globalToLocal(details.globalPosition);
                        setState(() {
                          points = List.from(points)..add(localPosition);
                        });
                      },
                      onPanEnd: (_) => setState(() => points.add(Offset.zero)),
                      child: CustomPaint(
                        size: Size(constraints.maxWidth, constraints.maxHeight),
                        painter: TracePainter(points),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: ElevatedButton.icon(
              onPressed: () => setState(() => points.clear()),
              icon: const Icon(Icons.refresh),
              label: const Text('Neu starten'),
            ),
          ),
        ],
      ),
    );
  }
}

class TracePainter extends CustomPainter {
  final List<Offset> points;

  TracePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.6)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != Offset.zero && points[i + 1] != Offset.zero) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(TracePainter oldDelegate) => true;
}
