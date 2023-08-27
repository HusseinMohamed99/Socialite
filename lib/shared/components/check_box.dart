import 'package:flutter/material.dart';
import 'package:socialite/shared/cubit/loginCubit/cubit.dart';
import 'package:socialite/shared/styles/color.dart';

Widget checkBox(BuildContext context, {Color? color}) {
  var cubit = LoginCubit.get(context);
  return Checkbox.adaptive(
    side: BorderSide(
      color: color ?? AppMainColors.whiteColor,
    ),
    activeColor: AppMainColors.mainColor,
    value: cubit.isCheck,
    onChanged: (e) {
      cubit.boxCheck(e!);
    },
  );
}
