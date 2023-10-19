import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/shared/utils/color_manager.dart';

Widget defaultMaterialButton({
  required Function function,
  required String text,
  double? width,
  double? height,
  double? radius,
  bool isUpperCase = true,
  Function? onTap,
  required BuildContext context,
  Color? color,
  Color? textColor,
}) {
  return Container(
    width: width ?? double.infinity,
    height: height ?? 40.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        radius ?? 8,
      ).r,
      color: color ?? ColorManager.whiteColor,
    ),
    child: MaterialButton(
      onPressed: () {
        function();
      },
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    ),
  );
}

Widget defaultTextButton({
  required Function function,
  required String text,
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  required BuildContext context,
}) {
  return TextButton(
    onPressed: () {
      function();
    },
    child: Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight),
    ),
  );
}

Widget defaultButton({
  required Function()? function,
  required Widget widget,
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  required BuildContext context,
}) {
  return MaterialButton(
    color: color,
    onPressed: function,
    child: widget,
  );
}
