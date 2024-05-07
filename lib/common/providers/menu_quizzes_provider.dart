
import 'package:flutter/widgets.dart';
import 'package:quizlet_clone/model/quiz/menu_quiz_model.dart';

class MenuQuizzesProvider extends ChangeNotifier{

  final List<MenuQuizModel> menuQuizzes = [];

  void addQuizzes(List<MenuQuizModel> quizzes){
    menuQuizzes.addAll(quizzes);
    print("PROVIDER:::: \n ${menuQuizzes}");
    notifyListeners();
  }
}