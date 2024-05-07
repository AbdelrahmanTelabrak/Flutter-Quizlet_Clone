import 'package:quizlet_clone/model/user/creator_model.dart';

class MenuQuizModel{
  String id;
  String title;
  int questionsNumber;
  CreatorQuizItemModel? creator;

  MenuQuizModel({required this.id, required this.title, required this.questionsNumber, this.creator});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['questionsNumber'] = questionsNumber;
    if (creator != null) {
      data['creator'] = creator!.toJson();
    }
    return data;
  }

  factory MenuQuizModel.fromJson(Map<String, dynamic> json) {
    return MenuQuizModel(
      id: json['id'] as String,
      title: json['title'] as String,
      questionsNumber: json['questionsNumber'] as int,
      creator: json['creator'] != null
          ? CreatorQuizItemModel.fromJson(json['creator'])
          : null,
    );
  }
}