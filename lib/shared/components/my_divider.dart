import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociality/shared/styles/color.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1.h,
      color: color ?? AppMainColors.dividerColor,
    );
  }
}
