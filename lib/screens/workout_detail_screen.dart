import 'package:flutter/material.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  const WorkoutDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chest & Biceps")),
      body: const Center(
        child: Text("Workout details will be here"),
      ),
    );
  }
}
