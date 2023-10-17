import 'package:flutter/material.dart';
import 'package:socialite/shared/cubit/loginCubit/cubit.dart';
import 'package:socialite/shared/utils/color_manager.dart';

Widget checkBox(BuildContext context, {Color? color}) {
  var cubit = LoginCubit.get(context);
  return Checkbox.adaptive(
    side: BorderSide(
      color: color ?? ColorManager.whiteColor,
    ),
    activeColor: ColorManager.mainColor,
    value: cubit.isCheck,
    onChanged: (e) {
      cubit.boxCheck(e!);
    },
  );
}
