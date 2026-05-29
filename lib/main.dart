import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(Reset30App(prefs: prefs));
}

class Reset30App extends StatelessWidget {
  final SharedPreferences prefs;
  const Reset30App({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RESET30',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: DashboardScreen(prefs: prefs),
      debugShowCheckedModeBanner: false,
    );
  }
}
