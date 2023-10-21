import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialite/shared/utils/color_manager.dart';

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: ColorManager.titanWithColor,
      fontSize: 16,
    );

enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = ColorManager.greenColor;
      break;

    case ToastStates.error:
      color = ColorManager.redColor;
      break;

    case ToastStates.warning:
      color = ColorManager.dividerColor;
      break;
  }
  return color;
}
