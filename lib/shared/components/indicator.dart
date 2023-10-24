import 'package:flutter/material.dart';
import 'package:socialite/shared/utils/color_manager.dart';

class AdaptiveIndicator extends StatelessWidget {
  const AdaptiveIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator.adaptive(
      backgroundColor: ColorManager.greyColor,
      valueColor: AlwaysStoppedAnimation<Color>(ColorManager.mainColor),
      strokeWidth: 6,
    );
  }
}
