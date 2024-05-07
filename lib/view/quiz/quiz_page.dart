import 'package:flutter/material.dart';
import 'package:quizlet_clone/common/colors.dart';
import 'package:quizlet_clone/model/question/question_model.dart';
import 'package:quizlet_clone/view/question/question_item.dart';
import 'package:quizlet_clone/view/widgets/appbar.dart';
import 'package:quizlet_clone/view/widgets/buttons.dart';
import 'package:quizlet_clone/view/widgets/drawer.dart';
import 'package:quizlet_clone/viewmodel/quiz/quiz_viewmodel.dart';

import '../widgets/texts.dart';

class QuizPage extends StatefulWidget {
  final String quizId;
  const QuizPage({super.key, required this.quizId});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _viewmodel = QuizViewModel();

  String quizId = 'VieAbmDj';
  late Future<List<QuestionModel>?> questions;
  int completed = 0, correctAnswers = 0;

  @override
  void initState() {
    super.initState();
    initQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: questions,
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: lightBackground,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              initQuestions();
              completed = 0; correctAnswers = 0;
              setState(() {});
            },
            backgroundColor: mainColor,
            shape: const OvalBorder(),
            elevation: 0,
            child: const Icon(
              Icons.refresh,
              color: Colors.white,
              size: 24,
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: boldText(_viewmodel.title, color: mainColor, size: 24),
            actions: [
              _buildScoreWidget(snapshot),
            ],
          ),
          body: widgetDecider(snapshot),
        );
      },
    );
  }

  Widget widgetDecider(AsyncSnapshot<List<QuestionModel>?> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator(color: mainColor));
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if ((snapshot.data == null)) {
      return Center(
        child: semiBoldText('No available Questions',
            size: 14, color: Colors.grey),
      );
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => MCQWidget(
                  question: snapshot.data![index].question,
                  options: snapshot.data![index].options,
                  correctOptionIndex: snapshot.data![index].options
                      .indexOf(snapshot.data![index].correctAnswer),
                  onAnswer: (isCorrect) {
                    completed++;
                    if (isCorrect) {
                      correctAnswers++;
                    }
                    setState(() {});
                  },
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemCount: snapshot.data!.length,
              ),
              const SizedBox(height: 50),
              // filledFullWidthButton(
              //   onPressed: () {
              //     questions = _viewmodel.getQuiz(quizId);
              //   },
              //   child: boldText('txt'),
              // ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildScoreWidget(AsyncSnapshot<List<QuestionModel>?> snapshot) {
    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
      int completedQuestions = snapshot.data!.length;
      // Here you would calculate the score based on the answers provided by the user
      double score = _calculateScore(snapshot.data!); // Implement this function
      return Container(
        margin: const EdgeInsets.only(right: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            semiBoldText('Completed: $completed', size: 14),
            semiBoldText('Score: $score | ${_viewmodel.grade}', size: 14),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

// This function is just a placeholder, you need to implement it according to your logic
  double _calculateScore(List<QuestionModel> questions) {
    return correctAnswers * (_viewmodel.grade / questions.length);
  }

  Future<void> initQuestions() async {
    questions = _viewmodel.getQuiz(widget.quizId);
    await questions;
  }
}
