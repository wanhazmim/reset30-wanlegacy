import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  final String name;
  final bool done;
  final int streak;
  final VoidCallback onTap;

  const HabitTile({
    super.key,
    required this.name,
    required this.done,
    required this.streak,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: GestureDetector(
          onTap: onTap,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              done ? Icons.check_circle : Icons.radio_button_unchecked,
              key: ValueKey(done),
              color: done ? Colors.teal : Colors.grey,
              size: 28,
            ),
          ),
        ),
        title: Text(
          name,
          style: TextStyle(
            decoration: done ? TextDecoration.lineThrough : null,
            color: done ? Colors.grey : null,
            fontWeight: done ? FontWeight.normal : FontWeight.w500,
          ),
        ),
        trailing: streak > 0
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.local_fire_department,
                      color: Colors.orange, size: 18),
                  const SizedBox(width: 2),
                  Text('$streak',
                      style: const TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold)),
                ],
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
