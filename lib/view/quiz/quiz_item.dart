import 'package:flutter/material.dart';
import 'package:quizlet_clone/common/colors.dart';
import 'package:quizlet_clone/common/paddings.dart';
import 'package:quizlet_clone/model/quiz/menu_quiz_model.dart';
import 'package:quizlet_clone/view/widgets/texts.dart';

class QuizItem extends StatelessWidget {
  final MenuQuizModel menuQuiz;

  const QuizItem({
    Key? key,
    required this.menuQuiz,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, 'quiz_page', arguments: menuQuiz.id);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow()
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  semiBoldText(menuQuiz.title, color: mainTextColor, size: 16),
                  const SizedBox(height: 5),
                  questionsNumber(menuQuiz.questionsNumber),
                ],
              ),
              if (menuQuiz.creator != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: getProfilePic(menuQuiz.creator!.profilePic),
                          radius: 15,
                        ),
                        const SizedBox(width: 12),
                        semiBoldText(menuQuiz.creator!.username, color: mainTextColor),
                      ],
                    ),
                    semiBoldText(menuQuiz.id, color: mainTextColor),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget questionsNumber(int number) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0x2800ffeb),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: semiBoldText('$number terms', color: mainTextColor, size: 10),
      ),
    );
  }

  ImageProvider<Object> getProfilePic(String? profilePic) {
    if ((profilePic != null)) {
      return NetworkImage(profilePic);
    } else {
      return AssetImage('assets/images/default_pic.png');
    }
  }
}
