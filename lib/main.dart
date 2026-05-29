import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const Reset30App());
}

class Reset30App extends StatelessWidget {
  const Reset30App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RESET30',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: false,
      ),
      home: const DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
