import 'package:flutter/material.dart';
import 'package:fitquest/screens/exercise_library_screen.dart';
import 'package:fitquest/screens/workout_history_screen.dart';
import 'package:fitquest/screens/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row( /* ... User info row ... */ ),
              const SizedBox(height: 40),
              _buildProfileOption(context, Icons.list_alt, "Exercise Library", "View all your exercises", const ExerciseLibraryScreen()),
              _buildProfileOption(context, Icons.history, "Workout Log", "See your past workouts", const WorkoutHistoryScreen()),
              _buildProfileOption(context, Icons.settings_outlined, "Settings", "App preferences", const SettingsScreen()),
              const Spacer(),
              TextButton(onPressed: () {}, child: const Text("Log Out", style: TextStyle(color: Colors.redAccent, fontSize: 16))),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(BuildContext context, IconData icon, String title, String subtitle, Widget screen) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(icon, size: 28),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
      ),
    );
  }
}
