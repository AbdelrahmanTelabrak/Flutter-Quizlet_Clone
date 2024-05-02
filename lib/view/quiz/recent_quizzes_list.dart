import 'package:flutter/material.dart';
import 'package:quizlet_clone/model/quiz/menu_quiz_model.dart';
import 'package:quizlet_clone/view/quiz/quiz_item.dart';

class RecentQuizzesListView extends StatelessWidget {
  final List<MenuQuizModel> quizzesList;
  const RecentQuizzesListView({super.key, required this.quizzesList});
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: (screenWidth/1.5)/2,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 20),
        itemBuilder: (context, index) => quizItem(
          screenWidth: screenWidth,
          menuQuiz: quizzesList[index],
        ),
        itemCount: quizzesList.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
