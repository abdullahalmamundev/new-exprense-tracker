import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About App"),
      ),

      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "Expense Tracker v1.0\n\nBuilt with Flutter, GetX and Hive Database.Power By MK",
        ),
      ),
    );
  }
}