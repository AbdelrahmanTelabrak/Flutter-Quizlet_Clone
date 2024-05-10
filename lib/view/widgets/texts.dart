import 'package:flutter/material.dart';

Widget boldText(String txt, { double size = 12, TextAlign align  = TextAlign.start, Color color = const Color(0xff586380)}){
  return Text(
    txt,
    textAlign: align,
    style: TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w700,
      color: color,
    ),
  );
}

Widget semiBoldText(String txt, { double size = 12, TextAlign align  = TextAlign.justify, Color color = const Color(0xff586380)}){
  return Text(
    txt,
    textAlign: align,
    style: TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w600,
      color: color,
    ),
  );
}

Widget mediumText(String txt, { double size = 12, TextAlign align  = TextAlign.justify, Color color = const Color(0xff586380)}){
  return Text(
    txt,
    textAlign: align,
    style: TextStyle(
      // overflow: TextOverflow.,
      fontSize: size,
      fontWeight: FontWeight.w500,
      color: color,
    ),
  );
}

Widget regularText(String txt, { double? size = 12, TextAlign align  = TextAlign.start, Color color = const Color(0xff586380)}){
  return Text(
    txt,
    textAlign: align,
    style: TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w400,
      color: color,
    ),
  );
}