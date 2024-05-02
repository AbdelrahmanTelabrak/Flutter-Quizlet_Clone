import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizlet_clone/model/quiz/quiz_model.dart';

class QuizRepository{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createQuiz(QuizModel quiz) async {
    try {
      final userDocRef = _db.collection("study_sets").doc(quiz.id);
      await userDocRef.set(quiz.toJson());
      print("Document ${quiz.id} successfully created!");
    } catch (error) {
      print("Failed to create document: $error");
    }
  }
}