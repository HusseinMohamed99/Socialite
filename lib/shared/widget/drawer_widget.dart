import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociality/pages/notifications/notifications_screen.dart';
import 'package:sociality/pages/password/change_password.dart';
import 'package:sociality/pages/post/save_post_screen.dart';
import 'package:sociality/pages/profile/my_profile_screen.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:sociality/shared/components/image_with_shimmer.dart';
import 'package:sociality/shared/components/indicator.dart';
import 'package:sociality/shared/components/logout.dart';
import 'package:sociality/shared/components/my_divider.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/styles/color.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key, required this.cubit});
  final SocialCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: cubit.isDark
          ? AppMainColors.titanWithColor
          : AppColorsDark.primaryDarkColor,
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
                        navigateTo(context, const MyProfileScreen());
                      },
                      cubit: cubit,
                      text: 'Profile',
                      iconData: IconlyBroken.user2,
                    ),
                    ListOfItem(
                      function: () {
                        navigateTo(context, const NotificationScreen());
                      },
                      cubit: cubit,
                      text: 'Notifications',
                      iconData: IconlyBroken.notification,
                    ),
                    ListOfItem(
                      function: () {
                        navigateTo(context, const SavePostScreen());
                      },
                      cubit: cubit,
                      text: 'Saved Post',
                      iconData: IconlyBroken.bookmark,
                    ),
                    ListOfItem(
                      function: () {
                        navigateTo(context, const EditPasswordScreen());
                      },
                      cubit: cubit,
                      text: 'Rest Password',
                      iconData: IconlyBroken.password,
                    ),
                    ListOfItem(
                      function: () {
                        cubit.changeAppMode();
                      },
                      cubit: cubit,
                      text: 'Theme Mode',
                      iconData: IconlyBroken.star,
                    ),
                    ListOfItem(
                      function: () {
                        logOut(context);
                      },
                      cubit: cubit,
                      text: 'Logout',
                      iconData: IconlyBroken.closeSquare,
                    ),
                  ],
                ),
                Positioned(
                  top: 160.h,
                  left: 40.w,
                  right: 40.w,
                  child: CircleAvatar(
                    backgroundColor: AppMainColors.blueColor,
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
          : AdaptiveIndicator(
              os: getOs(),
            ),
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
              color: AppMainColors.greyColor,
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
