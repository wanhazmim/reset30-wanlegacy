import 'package:flutter/material.dart';
import '../widgets/habit_tile.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  final List<Map<String, dynamic>> _habits = [
    {'name': 'Morning Exercise', 'done': false, 'streak': 0},
    {'name': 'Read 10 Pages', 'done': false, 'streak': 3},
    {'name': 'Drink 8 Glasses Water', 'done': false, 'streak': 7},
    {'name': 'Meditate 10 Minutes', 'done': false, 'streak': 1},
    {'name': 'No Social Media Before 9AM', 'done': false, 'streak': 5},
    {'name': 'Sleep Before Midnight', 'done': false, 'streak': 2},
    {'name': 'Healthy Breakfast', 'done': false, 'streak': 4},
  ];

  void _toggle(int index) {
    setState(() {
      final habit = _habits[index];
      habit['done'] = !(habit['done'] as bool);
      if (habit['done'] as bool) {
        habit['streak'] = (habit['streak'] as int) + 1;
      }
    });
  }

  int get _completedCount => _habits.where((h) => h['done'] == true).length;

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
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    '$_completedCount of ${_habits.length} completed',
                    style: TextStyle(color: Colors.teal.shade700),
                  ),
                ],
              ),
              CircleAvatar(
                backgroundColor: Colors.teal,
                radius: 28,
                child: Text(
                  '${(_completedCount / _habits.length * 100).toInt()}%',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _habits.length,
            itemBuilder: (context, i) => HabitTile(
              name: _habits[i]['name'] as String,
              done: _habits[i]['done'] as bool,
              streak: _habits[i]['streak'] as int,
              onTap: () => _toggle(i),
            ),
          ),
        ),
      ],
    );
  }
}
