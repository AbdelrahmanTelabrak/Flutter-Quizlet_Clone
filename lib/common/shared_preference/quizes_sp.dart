import 'dart:convert';

import 'package:quizlet_clone/model/quiz/menu_quiz_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuQuizzesSharedPreferences {
  static const String _keySavedQuizzes = 'quizzes';

  static Future<void> saveQuizInMenu(MenuQuizModel menuQuizModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? jsonDataList = prefs.getStringList(_keySavedQuizzes);
    List<MenuQuizModel> quizzes = [];
    if (jsonDataList != null) {
      quizzes = jsonDataList.map((jsonData) => MenuQuizModel.fromJson(jsonDecode(jsonData))).toList();
    }
    quizzes.add(menuQuizModel);
    final List<String> jsonList = quizzes.map((quiz) => jsonEncode(quiz.toJson())).toList();
    await prefs.setStringList(_keySavedQuizzes, jsonList);
  }

  static Future<List<MenuQuizModel>?> getSavedQuizzes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? jsonDataList = prefs.getStringList(_keySavedQuizzes);
    if (jsonDataList != null) {
      return jsonDataList.map((jsonData) => MenuQuizModel.fromJson(jsonDecode(jsonData))).toList();
    }
    return null;
  }

  static Future<void> removeSavedQuizzes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keySavedQuizzes);
  }
}