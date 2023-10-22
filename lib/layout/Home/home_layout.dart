import 'package:badges/badges.dart' as badges;
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialite/Pages/notifications/notifications_screen.dart';
import 'package:socialite/Pages/search/search_screen.dart';
import 'package:socialite/pages/login/login_screen.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/widget/drawer_widget.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          child: Scaffold(
              extendBody: true,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                elevation: 0,
                title: Text(
                  cubit.titles[cubit.currentIndex],
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        letterSpacing: 10,
                      ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      cubit.getAllUsers();
                      navigateTo(
                        context,
                        const SearchScreen(),
                      );
                    },
                    splashColor: ColorManager.blueColor,
                    splashRadius: 20,
                    icon: const Icon(
                      IconlyBroken.search,
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
                    splashColor: ColorManager.blueColor,
                    splashRadius: 20,
                    icon: SocialCubit.get(context).unReadNotificationsCount == 0
                        ? tabBarBadge(
                            context,
                            icon: IconlyBroken.notification,
                            count: SocialCubit.get(context)
                                .unReadNotificationsCount,
                          )
                        : const Icon(
                            IconlyBroken.notification,
                          ),
                  ),
                ],
              ),
              drawer: DrawerWidget(cubit: cubit),
              bottomNavigationBar: BottomNavigationBar(
                elevation: 0,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: cubit.bottomNavigationBarItem,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeNavBar(index);
                },
              ),
              body: uId != null
                  ? cubit.screens[cubit.currentIndex]
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Please Login First',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              navigateAndFinish(context, const LoginScreen());
                            },
                            child: const Text('Login'),
                          ),
                        ],
                      ),
                    )),
        );
      },
    );
  }

  Widget tabBarBadge(context, {required IconData icon, required int count}) {
    return badges.Badge(
      showBadge: true,
      ignorePointer: false,
      position: badges.BadgePosition.topStart(top: -15, start: -12),
      badgeContent: Text(
        "$count",
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: ColorManager.whiteColor),
      ),
      badgeAnimation: const badges.BadgeAnimation.rotation(
        animationDuration: Duration(seconds: 1),
        colorChangeAnimationDuration: Duration(seconds: 1),
        loopAnimation: false,
        curve: Curves.fastOutSlowIn,
        colorChangeAnimationCurve: Curves.easeInCubic,
      ),
      badgeStyle: const badges.BadgeStyle(
        padding: EdgeInsets.all(5),
        badgeColor: ColorManager.greenColor,
        shape: badges.BadgeShape.circle,
      ),
      child: Icon(
        icon,
      ),
    );
  }
}
