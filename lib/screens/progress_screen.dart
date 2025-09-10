import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fitquest/screens/weight_analytics_screen.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Your Progress"), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Weight Analytics", style: theme.textTheme.titleLarge),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WeightAnalyticsScreen())),
              child: Container(
                height: 150, width: double.infinity,
                decoration: BoxDecoration(color: theme.colorScheme.surface.withOpacity(0.5), borderRadius: BorderRadius.circular(20)),
                child: const Center(child: Text("Log more to see your chart!\n(Tap here for details)", textAlign: TextAlign.center)),
              ),
            ),
            const SizedBox(height: 30),
            Text("Today's Stats: Chest & Biceps", style: theme.textTheme.titleLarge),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(color: theme.colorScheme.surface, borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatColumn("0 / 1", "Exercises Done"),
                  _buildStatColumn("0%", "Completion"),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text("Workout Streak", style: theme.textTheme.titleLarge),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: theme.colorScheme.surface, borderRadius: BorderRadius.circular(20)),
              child: _buildCalendar(),
            )
          ],
        ),
      ),
    );
  }

  Column _buildStatColumn(String value, String label) { /* ... Same as before ... */ }
  
  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: DateTime.now(),
      calendarFormat: CalendarFormat.month,
      headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle),
        selectedDecoration: BoxDecoration(color: Colors.deepPurple, shape: BoxShape.circle),
      ),
      // Add event loader logic here later
    );
  }
}
