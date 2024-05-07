import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizlet_clone/model/quiz/menu_quiz_model.dart';
import 'package:quizlet_clone/view/quiz/quiz_item.dart';

import '../../common/providers/menu_quizzes_provider.dart';

class RecentQuizzesListView extends StatelessWidget {
  const RecentQuizzesListView({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) => QuizItem(
        menuQuiz: Provider.of<MenuQuizzesProvider>(context).menuQuizzes[index],
      ),
      itemCount: Provider.of<MenuQuizzesProvider>(context).menuQuizzes.length,
    );
  }
}
