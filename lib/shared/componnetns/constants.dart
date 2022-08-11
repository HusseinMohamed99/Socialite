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

String daysBetween(DateTime postDate){
  if  ((DateTime.now().difference(postDate).inHours / 24).round() == 0)
  {
    if(DateTime.now().difference(postDate).inHours == 0 )
      if(DateTime.now().difference(postDate).inMinutes == 0)
        return 'now';
      else
        return '${DateTime.now().difference(postDate).inMinutes.toString()} minutes';
    else
      return '${DateTime.now().difference(postDate).inHours.toString()} hours';
  }
  else
  {
    return (' ${(DateTime.now().difference(postDate).inHours / 24).round().toString()} days');
  }
}

String? uId = '';


