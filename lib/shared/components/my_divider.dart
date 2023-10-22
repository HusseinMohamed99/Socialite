import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/shared/utils/color_manager.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key, this.color, this.horizontal, this.vertical});
  final Color? color;
  final double? horizontal;
  final double? vertical;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: vertical ?? 0,
        horizontal: horizontal ?? 0,
      ),
      width: double.infinity,
      height: 1.h,
      color: color ?? ColorManager.dividerColor,
    );
  }
}
