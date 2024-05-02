import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/quiz/menu_quiz_model.dart';
import '../../model/user/creator_model.dart';

class HomeViewModel extends ChangeNotifier {
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('logged', false);
    prefs.setString('userData', '');
    Navigator.pushReplacementNamed(context, '/intro');
  }

  List<MenuQuizModel> getMenuQuizzes() {
    List<MenuQuizModel> quizList = [];

    for (int i = 1; i <= 10; i++) {
      CreatorQuizItemModel creator = CreatorQuizItemModel(
        username: "User$i",
        token: 'token: $i',
      );

      MenuQuizModel quiz = MenuQuizModel(
        id: i,
        title: "Quiz Title $i",
        qustionsNumber: i * 5, // Example number of questions
        creator: creator,
      );

      quizList.add(quiz);
    }
    return quizList;
  }
}
