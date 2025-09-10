import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fitquest/services/firestore_service.dart';

class ExerciseLibraryScreen extends StatefulWidget {
  const ExerciseLibraryScreen({super.key});

  @override
  _ExerciseLibraryScreenState createState() => _ExerciseLibraryScreenState();
}

class _ExerciseLibraryScreenState extends State<ExerciseLibraryScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _muscleGroupController = TextEditingController();

  void _showExerciseDialog({String? docID, String? currentName, String? currentMuscleGroup}) {
    _nameController.text = currentName ?? '';
    _muscleGroupController.text = currentMuscleGroup ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(docID == null ? 'Add Exercise' : 'Edit Exercise'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Exercise Name')),
              TextField(controller: _muscleGroupController, decoration: const InputDecoration(labelText: 'Muscle Group')),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                if (docID == null) {
                  _firestoreService.addExercise(_nameController.text, _muscleGroupController.text);
                } else {
                  _firestoreService.updateExercise(docID, _nameController.text, _muscleGroupController.text);
                }
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exercise Library")),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getExercisesStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List exercisesList = snapshot.data!.docs;
            // Group exercises by muscle group
            Map<String, List<DocumentSnapshot>> groupedExercises = {};
            for (var exercise in exercisesList) {
              String muscleGroup = exercise['muscleGroup'];
              if (groupedExercises[muscleGroup] == null) {
                groupedExercises[muscleGroup] = [];
              }
              groupedExercises[muscleGroup]!.add(exercise);
            }

            return ListView(
              padding: const EdgeInsets.all(20),
              children: groupedExercises.entries.map((entry) {
                String muscleGroup = entry.key;
                List<DocumentSnapshot> exercises = entry.value;
                return _buildMuscleGroup(context, muscleGroup, exercises);
              }).toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showExerciseDialog(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMuscleGroup(BuildContext context, String title, List<DocumentSnapshot> exercises) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        ...exercises.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return Card(
            color: Theme.of(context).colorScheme.surface,
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const Icon(Icons.fitness_center, color: Colors.white70),
              title: Text(data['name']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, color: Colors.white70),
                    onPressed: () => _showExerciseDialog(
                      docID: doc.id,
                      currentName: data['name'],
                      currentMuscleGroup: data['muscleGroup'],
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                    onPressed: () => _firestoreService.deleteExercise(doc.id),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
