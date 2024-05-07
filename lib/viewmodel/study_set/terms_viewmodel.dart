import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizlet_clone/common/common_functions.dart';
import 'package:quizlet_clone/common/providers/menu_quizzes_provider.dart';
import 'package:quizlet_clone/common/shared_preference/quizes_sp.dart';
import 'package:quizlet_clone/common/shared_preference/user_data_sp.dart';
import 'package:quizlet_clone/model/question/new_term_model.dart';
import 'package:quizlet_clone/model/quiz/menu_quiz_model.dart';
import 'package:quizlet_clone/model/quiz/quiz_model.dart';
import 'package:quizlet_clone/model/user/creator_model.dart';
import 'package:quizlet_clone/view/widgets/commons.dart';
import 'package:quizlet_clone/viewmodel/study_set/single_term_viewmodel.dart';

import '../../repository/quiz/quiz_repo.dart';

class TermsViewModel extends ChangeNotifier {
  final List<SingleTermViewModel> termsViewModel = [];
  final List<NewTermModel> formDataList = [];
  final formKey = GlobalKey<FormState>();
  final quizModel = QuizModel();
  final _repo = QuizRepository();

  TermsViewModel(int numberOfQuestions) {
    for (int i = 0; i < numberOfQuestions; i++) {
      termsViewModel.add(SingleTermViewModel());
    }
  }

  void submit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      for (int i = 0; i < termsViewModel.length; i++) {
        if (termsViewModel[i].formKey.currentState!.validate()) {
          addFormData(termsViewModel[i].getTerm());
        } else {
          formDataList.clear();
          continue;
        }
      }
      if (formDataList.length == termsViewModel.length) {
        ///================== UPLOAD TO FIREBASE ==================
        // Convert list of NewTermModel objects to JSON
        List<Map<String, dynamic>> jsonList =
            formDataList.map((term) => term.toJson()).toList();
        String jsonString = jsonEncode(jsonList);
        print('Json string: $jsonString');
        // Get user data:
        final userData = await UserSharedPreferences.getAccountData();
        final creator = CreatorQuizItemModel(
            username: userData!.username!,
            token: userData.uid!,
            profilePic: userData.profilePic);
        // create an object of QuizModel:
        // final quizModel = QuizModel(
        //     id: generateUniqueId(),
        //     title: 'test',
        //     questions: formDataList,
        //     creator: creator);
        quizModel.id = generateUniqueId();
        quizModel.questions = formDataList;
        quizModel.creator = creator;
        await _repo.createQuiz(quizModel);
        // Save quiz to the Home Screen
        final menuQuiz = MenuQuizModel(
          id: quizModel.id!,
          title: quizModel.title!,
          questionsNumber: quizModel.questions!.length,
          creator: creator,
        );
        await MenuQuizzesSharedPreferences.saveQuizInMenu(menuQuiz);
        Provider.of<MenuQuizzesProvider>(context, listen: false).addQuizzes([menuQuiz]);
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(mainSnackBar('Unfinished fields...'));
      }
    }
    // Optionally, you can perform additional actions after submitting all forms
    // For example, clear form fields, show a success message, etc.
  }

  void addFormData(NewTermModel term) {
    formDataList.add(term);
  }

  void updateTitle(String title) {
    quizModel.title = title;
  }

  void updateCategory(String category) {
    quizModel.category = category;
  }

  String? basicValidator(dynamic value) {
    if (value.isEmpty) {
      return 'Please enter your value';
    }
    return null;
  }
}
