import 'package:flutter/material.dart';

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); //800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
}

Widget space(double width, double height) {
  return SizedBox(
    width: width,
    height: height,
  );
}



String? uId = '';


