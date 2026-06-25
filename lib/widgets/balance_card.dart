import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {

  final String title;
  final double amount;
  final Color color;

  const SummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      margin:
      const EdgeInsets.all(8),

      child: ListTile(
        title: Text(title),

        trailing: Text(
          amount.toStringAsFixed(2),
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight:
            FontWeight.bold,
          ),
        ),
      ),
    );
  }
}