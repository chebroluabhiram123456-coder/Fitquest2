import 'package:flutter/material.dart';
import '../widgets/frosted_glass_card.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weekly Plan"), elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          _buildPlanCard("Monday", "Chest & Biceps"),
          _buildPlanCard("Tuesday", "Back & Triceps"),
          _buildPlanCard("Wednesday", "Legs & Shoulders"),
          _buildPlanCard("Thursday", "Rest"),
          _buildPlanCard("Friday", "Chest & Back"),
        ],
      ),
    );
  }

  Widget _buildPlanCard(String day, String muscleGroup) {
    return FrostedGlassCard(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(day, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 5),
              Text(muscleGroup, style: TextStyle(color: Colors.white.withOpacity(0.8))),
            ],
          ),
          Icon(Icons.edit_outlined, color: Colors.white.withOpacity(0.8)),
        ],
      ),
    );
  }
}
