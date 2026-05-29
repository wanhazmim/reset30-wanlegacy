import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  final String name;
  final bool done;
  final VoidCallback onTap;

  const HabitTile({
    super.key,
    required this.name,
    required this.done,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        done ? Icons.check_circle : Icons.radio_button_unchecked,
        color: done ? Colors.teal : Colors.grey,
      ),
      title: Text(
        name,
        style: TextStyle(
          decoration: done ? TextDecoration.lineThrough : null,
          color: done ? Colors.grey : null,
        ),
      ),
      onTap: onTap,
    );
  }
}
