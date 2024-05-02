import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizlet_clone/view/widgets/texts.dart';

Widget googleFullWidthButton() {
  return MaterialButton(
    onPressed: () {

    },
    minWidth: double.infinity,
    height: 50,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(width: 2, color: Color(0x80a2a2a2)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/icons/google_icon.svg', width: 25, height: 25,),
        SizedBox(width: 10,),
        semiBoldText('Log in with Google', size: 14, color: const Color(0xff586380)),
      ],
    ),
  );
}

Widget filledFullWidthButton({required Function() onPressed, required Widget child, Color color = const Color(0xff4255FF)}) {
  return MaterialButton(
    onPressed: onPressed,
    minWidth: double.infinity,
    height: 50,
    color: color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: child,
  );
}

Widget outlinedFullWidthButton({required Function() onPressed, required Widget child, Color color = const Color(0xff4255FF)}) {
  return MaterialButton(
    onPressed: onPressed,
    minWidth: double.infinity,
    height: 50,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(width: 2, color: Color(0x80a2a2a2)),
    ),
    child: child,
  );
}