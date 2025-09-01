import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TrainingPieChart extends StatelessWidget {
  final String title;
  final List<double> data;
  final List<Color> colors;
  final bool small; // ← add this

  const TrainingPieChart({
    super.key,
    required this.title,
    required this.data,
    required this.colors,
    this.small = false, // ← default value
  });

  @override
  Widget build(BuildContext context) {
    final chartHeight = small ? 150.0 : 220.0; // smaller if true
    final chartRadius = small ? 35.0 : 50.0;   // smaller radius if true

    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: chartHeight,
          child: PieChart(
            PieChartData(
              sections: List.generate(data.length, (i) {
                return PieChartSectionData(
                  value: data[i],
                  title: '',
                  color: colors[i % colors.length],
                  radius: chartRadius,
                );
              }),
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
