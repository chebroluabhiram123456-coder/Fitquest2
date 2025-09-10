import 'package:flutter/material.dart';

class WeightAnalyticsScreen extends StatelessWidget {
  const WeightAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Weight Analytics")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200, width: double.infinity,
              decoration: BoxDecoration(color: theme.colorScheme.surface.withOpacity(0.5), borderRadius: BorderRadius.circular(20)),
              child: const Center(child: Text("Log more than one weight entry\nto see your chart!", textAlign: TextAlign.center)),
            ),
            const SizedBox(height: 30),
            Text("History", style: theme.textTheme.titleLarge),
            const SizedBox(height: 20),
            const Expanded(
              child: Center(child: Text("No weight logged yet.", style: TextStyle(color: Colors.white70))),
            ),
          ],
        ),
      ),
    );
  }
}
