import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
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
import 'package:socialite/shared/utils/value_manager.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key, required this.cubit});
  final SocialCubit cubit;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double screenHeight = MediaQuery.sizeOf(context).height;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: cubit.userModel != null
            ? ListView(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              ImageWithShimmer(
                                imageUrl: cubit.userModel!.cover,
                                boxFit: BoxFit.fill,
                                height: screenHeight * .4,
                                width: double.infinity,
                              ),
                            ],
                          ),
                          const SizedBox(height: 50),
                          Text(
                            cubit.userModel!.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    fontFamily:
                                        GoogleFonts.pacifico().fontFamily),
                          ),
                          const MyDivider(
                            vertical: AppPadding.p12,
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
                              cubit.currentIndex = 0;
                              logOut(context);
                            },
                            cubit: cubit,
                            text: AppString.logout,
                            iconData: IconlyBroken.closeSquare,
                          ),
                        ],
                      ),
                      Positioned(
                        top: screenHeight * .35,
                        left: screenWidth * .25,
                        child: CircleAvatar(
                          backgroundColor: ColorManager.blueColor,
                          radius: 42,
                          child: CircleAvatar(
                            radius: 40,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: ImageWithShimmer(
                                imageUrl: cubit.userModel!.image,
                                boxFit: BoxFit.fill,
                                height: 200,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : const AdaptiveIndicator(),
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
    return GestureDetector(
      onTap: () {
        function!();
      },
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 30,
              color: ColorManager.greyColor,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
