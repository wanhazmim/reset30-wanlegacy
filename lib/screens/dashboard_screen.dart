import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'habit_screen.dart';
import 'progress_chart.dart';

class DashboardScreen extends StatefulWidget {
  final SharedPreferences prefs;
  const DashboardScreen({super.key, required this.prefs});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      HabitScreen(prefs: widget.prefs),
      ProgressChart(prefs: widget.prefs),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('RESET30'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.checklist), label: 'Habits'),
          NavigationDestination(
              icon: Icon(Icons.bar_chart), label: 'Progress'),
        ],
      ),
    );
  }
}
