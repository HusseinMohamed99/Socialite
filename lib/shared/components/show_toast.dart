import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialite/shared/styles/color.dart';

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
      textColor: AppMainColors.titanWithColor,
      fontSize: 16.sp,
    );

enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = AppMainColors.greenColor;
      break;

    case ToastStates.error:
      color = AppMainColors.redColor;
      break;

    case ToastStates.warning:
      color = AppMainColors.dividerColor;
      break;
  }
  return color;
}
