import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/habit_tile.dart';

class HabitScreen extends StatefulWidget {
  final SharedPreferences prefs;
  const HabitScreen({super.key, required this.prefs});

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  static const List<String> _habitNames = [
    'Morning Exercise',
    'Read 10 Pages',
    'Drink 8 Glasses Water',
    'Meditate 10 Minutes',
    'No Social Media Before 9AM',
    'Sleep Before Midnight',
    'Healthy Breakfast',
  ];

  late List<bool> _done;
  late List<int> _streaks;

  @override
  void initState() {
    super.initState();
    _loadAndCheckDay();
  }

  String get _todayKey {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  void _loadAndCheckDay() {
    final prefs = widget.prefs;
    final savedDate = prefs.getString('last_date') ?? '';
    final today = _todayKey;

    // Load streaks from storage
    _streaks = List.generate(
      _habitNames.length,
      (i) => prefs.getInt('streak_$i') ?? 0,
    );

    if (savedDate != today) {
      // New day — check if each habit was done yesterday, if not reset streak
      final wasDone = List.generate(
        _habitNames.length,
        (i) => prefs.getBool('done_$i') ?? false,
      );
      for (int i = 0; i < _habitNames.length; i++) {
        if (!wasDone[i]) {
          _streaks[i] = 0;
          prefs.setInt('streak_$i', 0);
        }
      }
      // Save weekly history for yesterday before resetting
      _saveYesterdayToHistory(savedDate, wasDone);

      // Reset today's done status
      _done = List.filled(_habitNames.length, false);
      for (int i = 0; i < _habitNames.length; i++) {
        prefs.setBool('done_$i', false);
      }
      prefs.setString('last_date', today);
    } else {
      // Same day — load saved done status
      _done = List.generate(
        _habitNames.length,
        (i) => prefs.getBool('done_$i') ?? false,
      );
    }
  }

  void _saveYesterdayToHistory(String date, List<bool> wasDone) {
    if (date.isEmpty) return;
    final completedCount = wasDone.where((d) => d).length;
    final pct = (completedCount / _habitNames.length * 100).round();
    // Store last 30 days as "date:pct" list
    final history = widget.prefs.getStringList('history') ?? [];
    history.add('$date:$pct');
    if (history.length > 30) history.removeAt(0);
    widget.prefs.setStringList('history', history);
  }

  void _toggle(int index) {
    final prefs = widget.prefs;
    setState(() {
      _done[index] = !_done[index];
      if (_done[index]) {
        _streaks[index]++;
      } else {
        if (_streaks[index] > 0) _streaks[index]--;
      }
    });
    prefs.setBool('done_$index', _done[index]);
    prefs.setInt('streak_$index', _streaks[index]);
  }

  int get _completedCount => _done.where((d) => d).length;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.teal.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today\'s Progress',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$_completedCount of ${_habitNames.length} completed',
                    style: TextStyle(color: Colors.teal.shade700),
                  ),
                ],
              ),
              CircleAvatar(
                backgroundColor: Colors.teal,
                radius: 28,
                child: Text(
                  '${(_completedCount / _habitNames.length * 100).toInt()}%',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _habitNames.length,
            itemBuilder: (context, i) => HabitTile(
              name: _habitNames[i],
              done: _done[i],
              streak: _streaks[i],
              onTap: () => _toggle(i),
            ),
          ),
        ),
      ],
    );
  }
}
