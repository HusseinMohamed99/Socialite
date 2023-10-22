import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialite/image_assets.dart';
import 'package:socialite/pages/addPost/add_post_screen.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';

class CreatePosts extends StatelessWidget {
  const CreatePosts({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 3,
          shadowColor: ColorManager.titanWithColor,
          margin: const EdgeInsets.all(AppPadding.p12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: Row(
              children: [
                cubit.userModel?.image != null
                    ? CircleAvatar(
                        radius: 25,
                        child: ImageWithShimmer(
                          radius: 25,
                          imageUrl: cubit.userModel!.image,
                          width: 100,
                          height: 100,
                          boxFit: BoxFit.fill,
                        ),
                      )
                    : SvgPicture.asset(Assets.images404error),
                Expanded(
                  child: Container(
                    width: screenWidth,
                    height: screenHeight * .06,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: const EdgeInsets.all(AppPadding.p8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorManager.greyColor.withOpacity(0.1),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextButton(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                      child: Text(
                        AppString.yourMind,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      onPressed: () {
                        navigateTo(context, const AddPostScreen());
                      },
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  height: 50,
                  color: Colors.grey,
                ),
                IconButton(
                  onPressed: () {
                    cubit.getPostImage();
                    navigateTo(context, const AddPostScreen());
                  },
                  icon: Icon(
                    IconlyBroken.image2,
                    size: 30,
                    color: cubit.isDark
                        ? CupertinoColors.activeBlue
                        : ColorManager.whiteColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
