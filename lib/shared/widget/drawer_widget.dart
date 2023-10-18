import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/pages/notifications/notifications_screen.dart';
import 'package:socialite/pages/post/save_post_screen.dart';
import 'package:socialite/pages/profile/user_profile_screen.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/components/indicator.dart';
import 'package:socialite/shared/components/logout.dart';
import 'package:socialite/shared/components/my_divider.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key, required this.cubit});
  final SocialCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: cubit.isDark
          ? ColorManager.titanWithColor
          : ColorManager.primaryDarkColor,
      child: cubit.userModel != null
          ? Stack(
              children: [
                Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        ImageWithShimmer(
                          imageUrl: cubit.userModel!.cover,
                          boxFit: BoxFit.fill,
                          height: 200.h,
                          width: double.infinity,
                        ),
                      ],
                    ),
                    SizedBox(height: 35.h),
                    Text(
                      cubit.userModel!.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20).r,
                      child: const MyDivider(color: Colors.cyan),
                    ),
                    ListOfItem(
                      function: () {
                        cubit.getUserPosts(uId);
                        cubit.getFriends(uId!);
                        navigateTo(context, const UserProfileScreen());
                      },
                      cubit: cubit,
                      text: AppString.profile,
                      iconData: IconlyBroken.user2,
                    ),
                    ListOfItem(
                      function: () {
                        navigateTo(context, const NotificationScreen());
                      },
                      cubit: cubit,
                      text: AppString.notifications,
                      iconData: IconlyBroken.notification,
                    ),
                    ListOfItem(
                      function: () {
                        navigateTo(context, const SavePostScreen());
                      },
                      cubit: cubit,
                      text: AppString.savePost,
                      iconData: IconlyBroken.bookmark,
                    ),
                    ListOfItem(
                      function: () {
                        cubit.changeAppMode();
                      },
                      cubit: cubit,
                      text: AppString.themeMode,
                      iconData: IconlyBroken.star,
                    ),
                    ListOfItem(
                      function: () {
                        logOut(context);
                      },
                      cubit: cubit,
                      text: AppString.logout,
                      iconData: IconlyBroken.closeSquare,
                    ),
                  ],
                ),
                Positioned(
                  top: 160.h,
                  left: 40.w,
                  right: 40.w,
                  child: CircleAvatar(
                    backgroundColor: ColorManager.blueColor,
                    radius: 42.r,
                    child: CircleAvatar(
                      radius: 40.r,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(65).r,
                        child: ImageWithShimmer(
                          imageUrl: cubit.userModel!.image,
                          boxFit: BoxFit.fill,
                          height: 200.h,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : const AdaptiveIndicator(),
    );
  }
}

class ListOfItem extends StatelessWidget {
  const ListOfItem({
    Key? key,
    required this.cubit,
    required this.iconData,
    required this.text,
    required this.function,
  }) : super(key: key);

  final SocialCubit cubit;
  final IconData iconData;
  final String text;
  final void Function()? function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function!();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20).r,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 30.sp,
              color: ColorManager.greyColor,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
