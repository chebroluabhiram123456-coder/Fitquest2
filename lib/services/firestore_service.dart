import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Get a reference to our 'exercises' collection
  final CollectionReference exercises =
      FirebaseFirestore.instance.collection('exercises');

  // CREATE: Add a new exercise
  Future<void> addExercise(String name, String muscleGroup) {
    return exercises.add({
      'name': name,
      'muscleGroup': muscleGroup,
      'timestamp': Timestamp.now(),
    });
  }

  // READ: Get exercises from the database
  Stream<QuerySnapshot> getExercisesStream() {
    return exercises.orderBy('muscleGroup').snapshots();
  }

  // UPDATE: Update an exercise's details
  Future<void> updateExercise(String docID, String newName, String newMuscleGroup) {
    return exercises.doc(docID).update({
      'name': newName,
      'muscleGroup': newMuscleGroup,
    });
  }

  // DELETE: Remove an exercise from the database
  Future<void> deleteExercise(String docID) {
    return exercises.doc(docID).delete();
  }
}
