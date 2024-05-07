import 'package:quizlet_clone/model/quiz/quiz_model.dart';

import '../../model/question/new_term_model.dart';
import '../../model/question/question_model.dart';
import '../../repository/quiz/quiz_repo.dart';

class QuizViewModel{
  final _repo = QuizRepository();
  String title = '';
  int grade = 0;

  Future<List<QuestionModel>?> getQuiz(String quizId) async {
    final quizModel = await _repo.getQuiz(quizId);
    title = quizModel!.title!;
    grade = quizModel.grade!;
    final List<QuestionModel> questions = [];
    for (var question in quizModel.questions!){
      questions.add(_createQuestion(question, quizModel.questions!));
    }
    return questions;
  }
  QuestionModel _createQuestion(NewTermModel newTermModel, List<NewTermModel> otherNewTermModels) {
    // Get 3 random terms from otherNewTermModels, excluding the correct term
    final randomTerms = otherNewTermModels
        .where((term) => term.term != newTermModel.term)
        .toList();
    randomTerms.shuffle();
    final selectedRandomTerms = randomTerms.take(3);

    // Create a list of options by combining the correct term and the random terms
    final List<String>options = [];
    options.add(newTermModel.term!);
    for (var term in selectedRandomTerms){
      options.add(term.term!);
    }
    options.shuffle();

    // Create the question object
    return QuestionModel(
      question: newTermModel.definition!,
      options: options, // Shuffle the options to randomize the order
      correctAnswer: newTermModel.term!,
    );
  }
}