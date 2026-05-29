import 'package:flutter/material.dart';
import '../widgets/line_chart.dart';

class ProgressChart extends StatelessWidget {
  const ProgressChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample weekly completion data (percentage per day)
    final data = [0.4, 0.6, 0.5, 0.8, 0.7, 0.9, 1.0];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Progress',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 220,
            child: HabitLineChart(data: data),
          ),
          const SizedBox(height: 16),
          const Text(
            '30-Day Challenge — keep the streak going!',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
