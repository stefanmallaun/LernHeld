import 'package:flutter/material.dart';
import 'letter_paths.dart';

class LetterTracingScreen extends StatefulWidget {
  final String letter;

  const LetterTracingScreen({super.key, required this.letter});

  @override
  State<LetterTracingScreen> createState() => _LetterTracingScreenState();
}

class _LetterTracingScreenState extends State<LetterTracingScreen> {
  List<Offset> points = [];

  double calculateAccuracy(List<Offset> userPoints, List<Path> scaledRefPaths) {
    const double tolerance = 30.0;
    final userCleaned = userPoints.where((p) => p != Offset.zero).toList();

    List<Offset> allRefPoints = [];
    for (final path in scaledRefPaths) {
      final metrics = path.computeMetrics();
      for (final metric in metrics) {
        for (double i = 0.0; i < metric.length; i += 5.0) {
          allRefPoints.add(metric.getTangentForOffset(i)!.position);
        }
      }
    }

    int hitCount = 0;
    for (final refPoint in allRefPoints) {
      for (final userPoint in userCleaned) {
        if ((userPoint - refPoint).distance < tolerance) {
          hitCount++;
          break;
        }
      }
    }

    if (allRefPoints.isEmpty) return 0;
    return (hitCount / allRefPoints.length) * 100;
  }

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
            child: LayoutBuilder(
              builder: (context, constraints) {
                final letterSize = Size(
                  constraints.maxWidth * 0.6,
                  constraints.maxHeight * 0.6,
                );
                final letterOffset = Offset(
                  (constraints.maxWidth - letterSize.width) / 2,
                  (constraints.maxHeight - letterSize.height) / 2,
                );

                final scaledPaths = letterPaths[widget.letter]!
                  .map((path) => _scalePath(path, letterOffset, letterSize))
                  .toList();

                final accuracy = calculateAccuracy(points, scaledPaths);

                return Stack(
                  children: [

                    // Zeichenbereich + Roter Pfad
                    Positioned.fill(
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          RenderBox box = context.findRenderObject() as RenderBox;
                          final localPosition = box.globalToLocal(details.globalPosition);
                          setState(() => points.add(localPosition));
                        },
                        onPanEnd: (_) => setState(() => points.add(Offset.zero)),
                        child: CustomPaint(
                          painter: TracePainter(points, scaledPaths),
                        ),
                      ),
                    ),
                    // Genauigkeit
                    Positioned(
                      left: 16,
                      bottom: 16,
                      child: Text(
                        'Genauigkeit: ${accuracy.toStringAsFixed(1)}%',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                );
              },
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

  Path _scalePath(Path original, Offset offset, Size size) {
    final matrix = Matrix4.identity()
      ..translate(offset.dx, offset.dy)
      ..scale(size.width, size.height);
    return original.transform(matrix.storage);
  }
}

class TracePainter extends CustomPainter {
  final List<Offset> points;
  final List<Path> refPaths;

  TracePainter(this.points, this.refPaths);

  @override
  void paint(Canvas canvas, Size size) {
    // Benutzerzeichnung (blau)
    final userPaint = Paint() 
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;


    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != Offset.zero && points[i + 1] != Offset.zero) {
        canvas.drawLine(points[i], points[i + 1], userPaint);
      }
    }

    // Referenzpfad (rot)
    final refPaint = Paint()
      ..color = Colors.red.withOpacity(0.4) // semi-transparent
      ..strokeWidth = 20                    // thicker
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (final path in refPaths) {
      canvas.drawPath(path, refPaint);
    }
  }

  @override
  bool shouldRepaint(covariant TracePainter oldDelegate) => true;
}
