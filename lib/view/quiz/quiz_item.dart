import 'package:flutter/material.dart';
import 'package:quizlet_clone/common/colors.dart';
import 'package:quizlet_clone/common/paddings.dart';
import 'package:quizlet_clone/model/quiz/menu_quiz_model.dart';
import 'package:quizlet_clone/view/widgets/texts.dart';

Widget quizItem({required double screenWidth, required MenuQuizModel menuQuiz, }){
  var width = screenWidth/1.5;
  return Container(
    width: width,
    // height: width/2,
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
              questionsNumber(menuQuiz.qustionsNumber),
            ],
          ),
          if (menuQuiz.creator != null)
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
        ],
      ),
    ),
  );
}

Widget questionsNumber(int number){
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

ImageProvider<Object> getProfilePic(String? profilePic){
  if ((profilePic != null)) {
    return NetworkImage(profilePic);
  } else {
    return AssetImage('assets/images/default_pic.png');
  }
}