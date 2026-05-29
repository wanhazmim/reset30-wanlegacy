import 'package:flutter/material.dart';
import '../widgets/line_chart.dart';

class ProgressChart extends StatelessWidget {
  const ProgressChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample weekly completion percentages
    final weekData = [40.0, 60.0, 50.0, 80.0, 70.0, 90.0, 100.0];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This Week',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: HabitLineChart(data: weekData),
          ),
          const SizedBox(height: 24),
          _StatCard(
            title: 'Best Streak',
            value: '7 days',
            icon: Icons.local_fire_department,
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          _StatCard(
            title: 'This Month',
            value: '18 / 30 days',
            icon: Icons.calendar_month,
            color: Colors.teal,
          ),
          const SizedBox(height: 12),
          _StatCard(
            title: 'Completion Rate',
            value: '70%',
            icon: Icons.percent,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(color: color, fontWeight: FontWeight.w600)),
              Text(value,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
