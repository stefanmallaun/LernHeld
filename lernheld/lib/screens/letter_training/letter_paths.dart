import 'package:flutter/material.dart';

final Map<String, List<Path>> letterPaths = {

  'A': [
      Path()
        ..moveTo(0.1, 0.43)
        ..lineTo(0.5, 0.0)
        ..lineTo(0.9, 0.43),
      Path()
        ..moveTo(0.25, 0.28)
        ..lineTo(0.75, 0.28),
    ],
    'B': [
      Path()
        ..moveTo(0.2, 0.0)
        ..lineTo(0.2, 1.0),
      Path()
        ..moveTo(0.2, 0.0)
        ..quadraticBezierTo(0.8, 0.0, 0.8, 0.3)
        ..quadraticBezierTo(0.8, 0.5, 0.2, 0.5),
      Path()
        ..moveTo(0.2, 0.5)
        ..quadraticBezierTo(0.8, 0.5, 0.8, 0.7)
        ..quadraticBezierTo(0.8, 1.0, 0.2, 1.0),
    ],

  'C': [
    Path()..moveTo(0.8, 0.1)..quadraticBezierTo(0.1, 0.1, 0.1, 0.5)..quadraticBezierTo(0.1, 0.9, 0.8, 0.9),
  ],
  'D': [
    Path()..moveTo(0.2, 0.0)..lineTo(0.2, 1.0),
    Path()..moveTo(0.2, 0.0)..quadraticBezierTo(0.9, 0.5, 0.2, 1.0),
  ],
  'E': [
    Path()..moveTo(0.8, 0.0)..lineTo(0.2, 0.0)..lineTo(0.2, 1.0)..lineTo(0.8, 1.0),
    Path()..moveTo(0.2, 0.5)..lineTo(0.6, 0.5),
  ],
  'F': [
    Path()..moveTo(0.2, 0.0)..lineTo(0.2, 1.0),
    Path()..moveTo(0.2, 0.0)..lineTo(0.8, 0.0),
    Path()..moveTo(0.2, 0.5)..lineTo(0.6, 0.5),
  ],
  'G': [
  // Großer Bogen mit Öffnung oben rechts
  Path()
    ..moveTo(0.85, 0.35)
    ..quadraticBezierTo(0.85, 0.1, 0.5, 0.05)
    ..quadraticBezierTo(0.15, 0.1, 0.15, 0.5)
    ..quadraticBezierTo(0.15, 0.9, 0.6, 0.9)
    ..quadraticBezierTo(0.85, 0.9, 0.85, 0.65),

  // Querstrich innen
  Path()
    ..moveTo(0.85, 0.65)
    ..lineTo(0.6, 0.65),
],

  'H': [
    Path()..moveTo(0.2, 0.0)..lineTo(0.2, 1.0),
    Path()..moveTo(0.8, 0.0)..lineTo(0.8, 1.0),
    Path()..moveTo(0.2, 0.5)..lineTo(0.8, 0.5),
  ],
  'I': [
    Path()..moveTo(0.5, 0.0)..lineTo(0.5, 1.0),
    Path()..moveTo(0.3, 0.0)..lineTo(0.7, 0.0),
    Path()..moveTo(0.3, 1.0)..lineTo(0.7, 1.0),
  ],
  'J': [
    Path()..moveTo(0.7, 0.0)..lineTo(0.7, 0.8)..quadraticBezierTo(0.7, 1.0, 0.5, 1.0)..quadraticBezierTo(0.3, 1.0, 0.3, 0.8),
  ],
  'K': [
    Path()..moveTo(0.2, 0.0)..lineTo(0.2, 1.0),
    Path()..moveTo(0.2, 0.5)..lineTo(0.8, 0.0),
    Path()..moveTo(0.2, 0.5)..lineTo(0.8, 1.0),
  ],
  'L': [
    Path()..moveTo(0.2, 0.0)..lineTo(0.2, 1.0)..lineTo(0.8, 1.0),
  ],
  'M': [
    Path()..moveTo(0.2, 1.0)..lineTo(0.2, 0.0)..lineTo(0.5, 0.5)..lineTo(0.8, 0.0)..lineTo(0.8, 1.0),
  ],
  'N': [
    Path()..moveTo(0.2, 1.0)..lineTo(0.2, 0.0)..lineTo(0.8, 1.0)..lineTo(0.8, 0.0),
  ],
  'O': [
    Path()..addOval(const Rect.fromLTWH(0.2, 0.1, 0.6, 0.8)),
  ],
  'P': [
    Path()..moveTo(0.2, 0.0)..lineTo(0.2, 1.0),
    Path()..moveTo(0.2, 0.0)..quadraticBezierTo(0.8, 0.0, 0.8, 0.3)..quadraticBezierTo(0.8, 0.5, 0.2, 0.5),
  ],
  'Q': [
    Path()..addOval(const Rect.fromLTWH(0.2, 0.1, 0.6, 0.8)),
    Path()..moveTo(0.6, 0.6)..lineTo(0.9, 1.0),
  ],
  'R': [
    Path()..moveTo(0.2, 0.0)..lineTo(0.2, 1.0),
    Path()..moveTo(0.2, 0.0)..quadraticBezierTo(0.8, 0.0, 0.8, 0.3)..quadraticBezierTo(0.8, 0.5, 0.2, 0.5),
    Path()..moveTo(0.2, 0.5)..lineTo(0.8, 1.0),
  ],
  'S': [
    Path()..moveTo(0.8, 0.2)..quadraticBezierTo(0.2, 0.2, 0.2, 0.5)..quadraticBezierTo(0.2, 0.8, 0.8, 0.8),
  ],
  'T': [
    Path()..moveTo(0.5, 0.0)..lineTo(0.5, 1.0),
    Path()..moveTo(0.2, 0.0)..lineTo(0.8, 0.0),
  ],
  'U': [
    Path()..moveTo(0.2, 0.0)..lineTo(0.2, 0.8)..quadraticBezierTo(0.2, 1.0, 0.5, 1.0)..quadraticBezierTo(0.8, 1.0, 0.8, 0.8)..lineTo(0.8, 0.0),
  ],
  'V': [
    Path()..moveTo(0.2, 0.0)..lineTo(0.5, 1.0)..lineTo(0.8, 0.0),
  ],
  'W': [
    Path()..moveTo(0.2, 0.0)..lineTo(0.35, 1.0)..lineTo(0.5, 0.5)..lineTo(0.65, 1.0)..lineTo(0.8, 0.0),
  ],
  'X': [
    Path()..moveTo(0.2, 0.0)..lineTo(0.8, 1.0),
    Path()..moveTo(0.8, 0.0)..lineTo(0.2, 1.0),
  ],
  'Y': [
    Path()..moveTo(0.2, 0.0)..lineTo(0.5, 0.5)..lineTo(0.8, 0.0),
    Path()..moveTo(0.5, 0.5)..lineTo(0.5, 1.0),
  ],
  'Z': [
    Path()..moveTo(0.2, 0.0)..lineTo(0.8, 0.0)..lineTo(0.2, 1.0)..lineTo(0.8, 1.0),
  ],
};
