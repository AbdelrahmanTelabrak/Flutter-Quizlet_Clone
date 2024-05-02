import 'package:flutter/material.dart';
import 'package:quizlet_clone/model/question/new_term_model.dart';

class SingleTermViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final termModel = NewTermModel();

  NewTermModel getTerm(){
    return termModel;
  }

  void updateTerm(String term) {
    termModel.term = term;
    notifyListeners();
  }

  void updateDefinition(String definition) {
    termModel.definition = definition;
    notifyListeners();
  }

  String? basicValidator(dynamic value) {
    if (value.isEmpty) {
      return 'Please enter your value';
    }
    return null;
  }
}