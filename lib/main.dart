import 'package:flutter/material.dart';
import 'package:smart_budget_app/pages/dashboard.dart';
import 'package:smart_budget_app/pages/log_in_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test viewer',
      theme: ThemeData.dark(),
      home: Dashboard(),
    );
  }

}
