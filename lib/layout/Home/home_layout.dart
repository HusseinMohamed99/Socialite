import 'package:badges/badges.dart' as badges;
import 'package:sociality/Pages/notifications/notifications_screen.dart';
import 'package:sociality/Pages/search/search_screen.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/cubit/socialCubit/social_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociality/shared/styles/color.dart';
import 'package:sociality/shared/widget/drawer_widget.dart';

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
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    navigateTo(
                      context,
                      const SearchScreen(),
                    );
                  },
                  splashColor: AppMainColors.blueColor,
                  splashRadius: 20.r,
                  icon: Icon(
                    IconlyBroken.search,
                    color: cubit.isDark
                        ? AppMainColors.greyDarkColor
                        : AppMainColors.kittenWithColor,
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
                  splashColor: AppMainColors.blueColor,
                  splashRadius: 20.r,
                  icon: SocialCubit.get(context).unReadNotificationsCount != 0
                      ? tabBarBadge(
                          icon: IconlyBroken.notification,
                          count:
                              SocialCubit.get(context).unReadNotificationsCount)
                      : Icon(
                          IconlyBroken.notification,
                          color: cubit.isDark
                              ? AppMainColors.greyDarkColor
                              : AppMainColors.kittenWithColor,
                          size: 24.sp,
                        ),
                ),
              ],
            ),
            drawer: DrawerWidget(cubit: cubit),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: cubit.isDark ? Colors.white : Colors.deepOrange,
              items: [
                BottomNavigationBarItem(
                    backgroundColor:
                        cubit.isDark ? Colors.white : Colors.deepOrange,
                    icon: const Icon(
                      Icons.home_outlined,
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                    backgroundColor:
                        cubit.isDark ? Colors.white : Colors.deepOrange,
                    icon: const Icon(
                      Icons.message,
                    ),
                    label: 'Chat'),
                BottomNavigationBarItem(
                    backgroundColor:
                        cubit.isDark ? Colors.white : Colors.deepOrange,
                    icon: const Icon(
                      Icons.supervised_user_circle_sharp,
                    ),
                    label: 'Friend'),
                BottomNavigationBarItem(
                    backgroundColor:
                        cubit.isDark ? Colors.white : Colors.deepOrange,
                    icon: const Icon(
                      Icons.location_history_outlined,
                    ),
                    label: 'Story'),
                BottomNavigationBarItem(
                    backgroundColor:
                        cubit.isDark ? Colors.white : Colors.deepOrange,
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
