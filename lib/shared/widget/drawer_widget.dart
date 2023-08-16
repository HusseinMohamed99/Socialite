import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                            ).r,
                          ),
                          width: double.infinity,
                          height: 200.h,
                          child: CachedNetworkImage(
                            imageUrl: cubit.userModel!.cover,
                            fit: BoxFit.fill,
                            height: 200.h,
                            width: double.infinity,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: AdaptiveIndicator(
                                os: getOs(),
                              ),
                            ),
                            errorWidget: (context, url, error) => Center(
                              child: AdaptiveIndicator(
                                os: getOs(),
                              ),
                            ),
                          ),
                        ),
                        // CircleAvatar(
                        //   backgroundColor: Colors.blueAccent,
                        //   radius: 42.r,
                        //   child: CircleAvatar(
                        //     radius: 40.r,
                        //     child: ClipRRect(
                        //       borderRadius: BorderRadius.circular(65).r,
                        //       child: CachedNetworkImage(
                        //         imageUrl: cubit.userModel!.image,
                        //         fit: BoxFit.fill,
                        //         height: 200.h,
                        //         width: double.infinity,
                        //         progressIndicatorBuilder:
                        //             (context, url, downloadProgress) =>
                        //             Center(
                        //               child: AdaptiveIndicator(
                        //                 os: getOs(),
                        //               ),
                        //             ),
                        //         errorWidget: (context, url, error) =>
                        //             Center(
                        //               child: AdaptiveIndicator(
                        //                 os: getOs(),
                        //               ),
                        //             ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    space(0, 35.h),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            cubit.userModel!.name.toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 30.sp,
                                color:
                                    cubit.isDark ? Colors.black : Colors.white),
                          ),
                          const MyDivider(color: Colors.cyan),
                          InkWell(
                            onTap: () {
                              SocialCubit.get(context).getMyPosts(uId);
                              SocialCubit.get(context).getFriends(uId!);
                              navigateTo(context, const MyProfileScreen());
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 20)
                                  .r,
                              child: Row(
                                children: [
                                  Icon(
                                    IconlyBroken.user2,
                                    size: 30.sp,
                                    color: cubit.isDark
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Profile',
                                    style: GoogleFonts.roboto(
                                        fontSize: 30,
                                        color: cubit.isDark
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              navigateTo(context, const NotificationScreen());
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 20)
                                  .r,
                              child: Row(
                                children: [
                                  Icon(
                                    IconlyBroken.notification,
                                    size: 30.sp,
                                    color: cubit.isDark
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Notifications',
                                    style: GoogleFonts.roboto(
                                        fontSize: 30,
                                        color: cubit.isDark
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              navigateTo(context, const SavePostScreen());
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 20)
                                  .r,
                              child: Row(
                                children: [
                                  Icon(
                                    IconlyBroken.bookmark,
                                    size: 30.sp,
                                    color: cubit.isDark
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Saved Post',
                                    style: GoogleFonts.roboto(
                                        fontSize: 30,
                                        color: cubit.isDark
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              navigateTo(context, const EditPasswordScreen());
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 20)
                                  .r,
                              child: Row(
                                children: [
                                  Icon(
                                    IconlyBroken.password,
                                    size: 30.sp,
                                    color: cubit.isDark
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Rest Password',
                                    style: GoogleFonts.roboto(
                                        fontSize: 30,
                                        color: cubit.isDark
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              cubit.changeAppMode();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 20)
                                  .r,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.dark_mode,
                                    size: 30.sp,
                                    color: cubit.isDark
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Theme Mode',
                                    style: GoogleFonts.roboto(
                                        fontSize: 30,
                                        color: cubit.isDark
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              logOut(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 20)
                                  .r,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.power_settings_new_rounded,
                                    size: 30.sp,
                                    color: cubit.isDark
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Logout',
                                    style: GoogleFonts.roboto(
                                      fontSize: 30.sp,
                                      color: cubit.isDark
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 160.r,
                  left: 40.r,
                  right: 40.r,
                  child: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
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
