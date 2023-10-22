import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';

class SettingsListItem extends StatelessWidget {
  const SettingsListItem({
    super.key,
    required this.cubit,
    required this.text,
    required this.iconData,
    required this.function,
  });

  final SocialCubit cubit;
  final String text;
  final IconData iconData;
  final void Function()? function;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cubit.isDark
          ? ColorManager.titanWithColor
          : ColorManager.blackColor.withOpacity(0.5),
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: GestureDetector(
          onTap: () {
            function!();
          },
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(AppPadding.p8),
                decoration: BoxDecoration(
                  color: ColorManager.blueColor.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  iconData,
                  size: 45,
                  color: ColorManager.greyColor,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                text,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              const Icon(
                IconlyBroken.arrowRight2,
                color: ColorManager.greyColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
