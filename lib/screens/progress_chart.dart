import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/line_chart.dart';

class ProgressChart extends StatelessWidget {
  final SharedPreferences prefs;
  const ProgressChart({super.key, required this.prefs});

  List<double> _getWeekData() {
    final history = prefs.getStringList('history') ?? [];
    // Get last 7 entries
    final recent = history.length > 7
        ? history.sublist(history.length - 7)
        : history;
    // Pad with zeros if less than 7 days
    final padded = List<double>.filled(7, 0);
    for (int i = 0; i < recent.length; i++) {
      final parts = recent[i].split(':');
      if (parts.length == 2) {
        padded[i + (7 - recent.length)] = double.tryParse(parts[1]) ?? 0;
      }
    }
    return padded;
  }

  int _getBestStreak() {
    int best = 0;
    for (int i = 0; i < 7; i++) {
      final s = prefs.getInt('streak_$i') ?? 0;
      if (s > best) best = s;
    }
    return best;
  }

  int _getDaysActive() {
    final history = prefs.getStringList('history') ?? [];
    return history.where((e) {
      final parts = e.split(':');
      return parts.length == 2 && (int.tryParse(parts[1]) ?? 0) > 0;
    }).length;
  }

  int _getAvgCompletion() {
    final history = prefs.getStringList('history') ?? [];
    if (history.isEmpty) return 0;
    final total = history.fold<int>(0, (sum, e) {
      final parts = e.split(':');
      return sum + (int.tryParse(parts.length == 2 ? parts[1] : '0') ?? 0);
    });
    return total ~/ history.length;
  }

  @override
  Widget build(BuildContext context) {
    final weekData = _getWeekData();
    final bestStreak = _getBestStreak();
    final daysActive = _getDaysActive();
    final avgCompletion = _getAvgCompletion();

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
            value: '$bestStreak day${bestStreak == 1 ? '' : 's'}',
            icon: Icons.local_fire_department,
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          _StatCard(
            title: 'Days Active (30 days)',
            value: '$daysActive / 30 days',
            icon: Icons.calendar_month,
            color: Colors.teal,
          ),
          const SizedBox(height: 12),
          _StatCard(
            title: 'Avg Completion Rate',
            value: '$avgCompletion%',
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
      width: double.infinity,
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
                  style:
                      TextStyle(color: color, fontWeight: FontWeight.w600)),
              Text(
                value,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
