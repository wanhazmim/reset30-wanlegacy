import 'package:flutter/material.dart';
import '../widgets/habit_tile.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  final List<Map<String, dynamic>> _habits = [
    {'name': 'Morning Exercise', 'done': false},
    {'name': 'Read 10 Pages', 'done': false},
    {'name': 'Drink 8 Glasses Water', 'done': false},
    {'name': 'Meditate 10 Minutes', 'done': false},
    {'name': 'No Social Media Before 9AM', 'done': false},
  ];

  void _toggle(int index) {
    setState(() => _habits[index]['done'] = !_habits[index]['done']);
  }

  @override
  Widget build(BuildContext context) {
    final completed = _habits.where((h) => h['done'] == true).length;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Day Progress: $completed / ${_habits.length}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _habits.length,
            itemBuilder: (context, i) => HabitTile(
              name: _habits[i]['name'] as String,
              done: _habits[i]['done'] as bool,
              onTap: () => _toggle(i),
            ),
          ),
        ),
      ],
    );
  }
}
