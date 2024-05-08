import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizlet_clone/common/providers/menu_quizzes_provider.dart';
import 'package:quizlet_clone/common/shared_preference/quizes_sp.dart';
import 'package:quizlet_clone/model/quiz/quiz_model.dart';
import 'package:quizlet_clone/repository/quiz/quiz_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/quiz/menu_quiz_model.dart';
import '../../model/user/creator_model.dart';

class HomeViewModel {
  final _repo = QuizRepository();

  Future<void> getMenuQuizzes(BuildContext context) async {
    final quizzes = await MenuQuizzesSharedPreferences.getSavedQuizzes();
    print('Home::: \n ${quizzes}');
    if (quizzes != null) {
      Provider.of<MenuQuizzesProvider>(context, listen: false)
          .addQuizzes(quizzes);
    }
  }

  void addMenuQuiz(BuildContext context, MenuQuizModel menuQuiz) {
    Provider.of<MenuQuizzesProvider>(context, listen: false)
        .addQuizzes([menuQuiz]);
  }

  Future<MenuQuizModel> getQuizByCode(BuildContext context, String id) async {
    final quizModel = await _repo.getQuiz(id);
    final menuQuiz = MenuQuizModel(
        id: quizModel!.id!,
        title: quizModel.title!,
        questionsNumber: quizModel.questions!.length,
        creator: quizModel.creator
    );
    print(menuQuiz.toJson());
    // addMenuQuiz(context, menuQuiz);
    await MenuQuizzesSharedPreferences.saveQuizInMenu(menuQuiz);
    return menuQuiz;
  }
}
