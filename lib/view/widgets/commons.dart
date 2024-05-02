import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quizlet_clone/common/colors.dart';
import 'package:quizlet_clone/view/widgets/texts.dart';

Widget termsConditionsRichText({TextAlign align = TextAlign.center}){
  return RichText(
    textAlign: align,
    softWrap: true,
    text: TextSpan(
      text: 'By clicking Log in, you accept Quizlet\'s ',
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xffADA4A5),
      ),
      children: [
        TextSpan(
          text: 'Privacy Policy',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xff586380),
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              /// Open privacy policy
            },
        ),
        const TextSpan(
          text: ' and ',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xffADA4A5),
          ),
        ),
        TextSpan(
          text: 'Term of Use',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xff586380),
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              /// Open Term of Use
            },
        ),
      ],
    ),
  );
}

SnackBar mainSnackBar(String message){
  return SnackBar(content: mediumText(message, color: Colors.white), backgroundColor: mainColor,);
}