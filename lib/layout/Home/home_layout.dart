import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:f_app/Pages/notifications/notifications_screen.dart';
import 'package:f_app/Pages/password/change_password.dart';
import 'package:f_app/Pages/profile/my_profile_screen.dart';
import 'package:f_app/Pages/search/search_screen.dart';
import 'package:f_app/adaptive/indicator.dart';
import 'package:f_app/pages/post/save_post_screen.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialState.dart';
import 'package:f_app/shared/components/components.dart';
import 'package:f_app/shared/components/constants.dart';
import 'package:f_app/shared/styles/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              titleSpacing: 0.0,
              title: Text(
                cubit.titles[cubit.currentIndex],
                style: GoogleFonts.roboto(
                  color: cubit.isLight ? Colors.blue : Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    navigateTo(
                      context,
                      const SearchScreen(),
                    );
                  },
                  splashColor: Colors.blue,
                  splashRadius: 20.r,
                  icon: Icon(
                    IconlyBroken.search,
                    color: cubit.isLight ? Colors.black : Colors.white,
                    size: 24.sp,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    cubit.getInAppNotification();
                    navigateTo(
                      context,
                      const NotificationScreen(),
                    );
                  },
                  splashColor: Colors.blue,
                  splashRadius: 20.r,
                  icon: SocialCubit.get(context).unReadNotificationsCount != 0
                      ? tabBarBadge(
                          icon: IconlyBroken.notification,
                          count:
                              SocialCubit.get(context).unReadNotificationsCount)
                      : Icon(
                          IconlyBroken.notification,
                          color: cubit.isLight ? Colors.black : Colors.white,
                          size: 24.sp,
                        ),
                ),
              ],
            ),
            drawer: Drawer(
              backgroundColor:
                  cubit.isLight ? ThemeApp.white : ThemeApp.darkPrimary,
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
                                        (context, url, downloadProgress) =>
                                            Center(
                                      child: AdaptiveIndicator(
                                        os: getOs(),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Center(
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
                                        color: cubit.isLight
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                  myDivider(Colors.cyan),
                                  InkWell(
                                    onTap: () {
                                      SocialCubit.get(context).getMyPosts(uId);
                                      SocialCubit.get(context).getFriends(uId);
                                      navigateTo(
                                          context, const MyProfileScreen());
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
                                            color: cubit.isLight
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
                                                color: cubit.isLight
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      navigateTo(
                                          context, const NotificationScreen());
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
                                            color: cubit.isLight
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
                                                color: cubit.isLight
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      navigateTo(
                                          context, const SavePostScreen());
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
                                            color: cubit.isLight
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
                                                color: cubit.isLight
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      navigateTo(
                                          context, const EditPasswordScreen());
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
                                            color: cubit.isLight
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
                                                color: cubit.isLight
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cubit.changeMode();
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
                                            color: cubit.isLight
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
                                                color: cubit.isLight
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
                                      FirebaseAuth.instance.signOut();
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
                                            color: cubit.isLight
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
                                              color: cubit.isLight
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
                          top: 180.r,
                          left: 40.r,
                          right: 40.r,
                          child: CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            radius: 42.r,
                            child: CircleAvatar(
                              radius: 40.r,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(65).r,
                                child: CachedNetworkImage(
                                  imageUrl: cubit.userModel!.image,
                                  fit: BoxFit.fill,
                                  height: 200.h,
                                  width: double.infinity,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
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
                            ),
                          ),
                        ),
                      ],
                    )
                  : AdaptiveIndicator(
                      os: getOs(),
                    ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor:
                  cubit.isLight ? ThemeApp.white : ThemeApp.darkPrimary,
              items: [
                BottomNavigationBarItem(
                    backgroundColor:
                        cubit.isLight ? ThemeApp.white : ThemeApp.darkPrimary,
                    icon: const Icon(
                      Icons.home_outlined,
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                    backgroundColor:
                        cubit.isLight ? ThemeApp.white : ThemeApp.darkPrimary,
                    icon: const Icon(
                      Icons.message,
                    ),
                    label: 'Chat'),
                BottomNavigationBarItem(
                    backgroundColor:
                        cubit.isLight ? ThemeApp.white : ThemeApp.darkPrimary,
                    icon: const Icon(
                      Icons.supervised_user_circle_sharp,
                    ),
                    label: 'Friend'),
                BottomNavigationBarItem(
                    backgroundColor:
                        cubit.isLight ? ThemeApp.white : ThemeApp.darkPrimary,
                    icon: const Icon(
                      Icons.location_history_outlined,
                    ),
                    label: 'Story'),
                BottomNavigationBarItem(
                    backgroundColor:
                        cubit.isLight ? ThemeApp.white : ThemeApp.darkPrimary,
                    icon: const Icon(
                      Icons.settings,
                    ),
                    label: 'Settings'),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeNavBar(index);
              },
            ),
            body: cubit.screens[cubit.currentIndex]);
      },
    );
  }

  Widget tabBarBadge({required IconData icon, required int count}) {
    return badges.Badge(
      badgeContent: Text('$count'),
      child: Icon(icon),
    );
  }
}
