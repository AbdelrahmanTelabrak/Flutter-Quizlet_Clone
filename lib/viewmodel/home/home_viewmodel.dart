import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizlet_clone/common/providers/menu_quizzes_provider.dart';
import 'package:quizlet_clone/common/shared_preference/quizes_sp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/quiz/menu_quiz_model.dart';
import '../../model/user/creator_model.dart';

class HomeViewModel {
  Future<void> getMenuQuizzes(BuildContext context) async{
    final quizzes = await MenuQuizzesSharedPreferences.getSavedQuizzes();
    print('Home::: \n ${quizzes}');
    if (quizzes != null) {
      Provider.of<MenuQuizzesProvider>(context, listen: false).addQuizzes(quizzes);
    }
  }

  void addMenuQuiz(BuildContext context, MenuQuizModel menuQuiz) async {
    Provider.of<MenuQuizzesProvider>(context, listen: false).addQuizzes([menuQuiz]);
  }
}
