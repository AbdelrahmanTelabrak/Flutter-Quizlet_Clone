import 'package:quizlet_clone/model/user/creator_model.dart';

class MenuQuizModel{
  int id;
  String title;
  int qustionsNumber;
  CreatorQuizItemModel? creator;

  MenuQuizModel({required this.id, required this.title, required this.qustionsNumber, this.creator});
}