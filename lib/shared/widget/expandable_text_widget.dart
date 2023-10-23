import 'package:flutter/material.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    SocialCubit cubit = SocialCubit.get(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      AnimatedSize(
        duration: const Duration(milliseconds: 250),
        child: ConstrainedBox(
          constraints: expanded
              ? const BoxConstraints()
              : const BoxConstraints(maxHeight: 85),
          child: Text(
            widget.text,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: cubit.isDark
                      ? ColorManager.titanWithColor
                      : ColorManager.blackColor,
                ),
            overflow: TextOverflow.fade,
          ),
        ),
      ),
      expanded
          ? OutlinedButton.icon(
              icon: const Icon(
                Icons.arrow_upward,
                color: ColorManager.redColor,
              ),
              label: const Text(
                AppString.readLess,
                style: TextStyle(
                  color: ColorManager.greenColor,
                ),
              ),
              onPressed: () => setState(() => expanded = false))
          : OutlinedButton.icon(
              icon: const Icon(
                Icons.arrow_downward,
                color: ColorManager.redColor,
              ),
              label: const Text(
                AppString.readMore,
                style: TextStyle(
                  color: ColorManager.greenColor,
                ),
              ),
              onPressed: () => setState(() => expanded = true))
    ]);
  }
}
