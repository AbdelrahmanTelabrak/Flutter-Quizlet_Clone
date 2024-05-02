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
      {required this.id,
      this.category,
      this.grade = 100,
      required this.title,
      required this.questions,
      required this.creator});

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
