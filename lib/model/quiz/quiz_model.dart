import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizlet_clone/model/question/new_term_model.dart';
import 'package:quizlet_clone/model/user/creator_model.dart';

class QuizModel {
  String? id;
  String? category;
  int? grade;
  String? title;
  List<NewTermModel>? questions;
  CreatorQuizItemModel? creator;

  QuizModel(
      {this.id,
      this.category,
      this.grade = 100,
      this.title,
      this.questions,
      this.creator});

  factory QuizModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return QuizModel(
      id: snapshot.id,
      category: data?['category'],
      grade: data?['grade'],
      title: data?['title'],
      questions: (data?['questions'] as List<dynamic>?)
          ?.map((question) => NewTermModel.fromJson(question))
          .toList(),
      creator: CreatorQuizItemModel.fromJson(data?['creator']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'grade': grade,
      'title': title,
      'questions': questions?.map((question) => question.toJson()).toList(),
      'creator': creator?.toJson(),
    };
  }
}
