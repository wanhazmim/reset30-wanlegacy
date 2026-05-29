import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HabitLineChart extends StatelessWidget {
  final List<double> data;

  const HabitLineChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final spots = data
        .asMap()
        .entries
        .map((e) => FlSpot(e.key.toDouble(), e.value * 100))
        .toList();

    return LineChart(
      LineChartData(
        minY: 0,
        maxY: 100,
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: true),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                final i = value.toInt();
                if (i < 0 || i >= days.length) return const SizedBox.shrink();
                return Text(days[i], style: const TextStyle(fontSize: 10));
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) =>
                  Text('${value.toInt()}%', style: const TextStyle(fontSize: 10)),
              reservedSize: 36,
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.teal,
            barWidth: 3,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.teal.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}
