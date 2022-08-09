import 'package:f_app/Pages/Login/login_screen.dart';
import 'package:f_app/Pages/drawer/drawerItem.dart';
import 'package:f_app/model/drawerModel.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialState.dart';
import 'package:f_app/shared/componnetns/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drawerController = ZoomDrawerController();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return ZoomDrawer(
          controller: drawerController,
          borderRadius: 50.0,
          dragOffset: 10.0,
          slideWidth: 290.0,
          style: DrawerStyle.defaultStyle,
          menuScreen: Builder(builder: (context) {
            return MenuScreen(
              currentItem: cubit.currentItem,
              onSelectedItem: (item) {
                cubit.changeItem(item, context);
                ZoomDrawer.of(context)!.toggle();
              },
            );
          }),
          mainScreen: cubit.mScreen,
          showShadow: true,
          menuBackgroundColor: Colors.grey[300]!,
          drawerShadowsBackgroundColor: cubit.isDark? Colors.grey.shade400: Colors.blue.shade200,
          reverseDuration: const Duration(milliseconds: 250),
          openCurve: Curves.fastOutSlowIn,
          closeCurve: Curves.bounceIn,
          angle: -9,
          duration: const Duration(milliseconds: 250),
        );
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return DefaultTabController(
          length: cubit.screens.length,
          initialIndex: cubit.currentIndex,
          child: Scaffold(
            backgroundColor:
                cubit.isDark ? Colors.white : const Color(0xff063750),
            appBar: AppBar(
              backgroundColor:
                  cubit.isDark ? Colors.white : const Color(0xff063750),
              elevation: 5,
              leading: IconButton(
                onPressed: () {
                  ZoomDrawer.of(context)!.toggle();
                },
                icon: Icon(
                  Icons.menu,
                  color: cubit.isDark ? const Color(0xff063750) : Colors.white,
                ),
              ),
              titleSpacing: 0.0,
              title: Text(
                cubit.titles[cubit.currentIndex],
                style: GoogleFonts.lobster(
                  color: cubit.isDark ? Colors.blue : Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  splashColor: Colors.blue,
                  splashRadius: 20,
                  icon: Icon(
                    IconlyBroken.search,
                    color: cubit.isDark ? Colors.black : Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  splashColor: Colors.blue,
                  splashRadius: 20,
                  icon: Icon(
                    IconlyBroken.notification,
                    color: cubit.isDark ? Colors.black : Colors.white,
                  ),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(40.0),
                child: TabBar(
                  onTap: (index) {
                    changeTabBar(cubit, index, context);
                  },
                  indicatorWeight: 4.0,
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 25),
                  splashFactory: InkSplash.splashFactory,
                  isScrollable: true,
                  indicatorColor: cubit.isDark ? Colors.blue : Colors.white,
                  labelColor: cubit.isDark ? Colors.blue : Colors.white,
                  unselectedLabelColor:
                      cubit.isDark ? Colors.black26 : Colors.grey[600],
                  tabs: cubit.tabs,
                ),
              ),
            ),
            body: cubit.screens[cubit.currentIndex],
          ),
        );
      },
    );
  }

  void changeTabBar(SocialCubit cubit, int index, BuildContext context) {
    cubit.changeTabBar(index, context);
  }
}

class MenuScreen extends StatelessWidget {
  final Items currentItem;
  final ValueChanged<Items> onSelectedItem;

  const MenuScreen(
      {Key? key, required this.currentItem, required this.onSelectedItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          backgroundColor: cubit.isDark
              ? Colors.white.withOpacity(0.4)
              : const Color(0xff063750),
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/background.jpg'),
                    radius: 70,
                  ),
                ),
                Text(
                  'Hussein Mohamed',
                  style: GoogleFonts.lobster(
                      fontSize: 30,
                      color: cubit.isDark ? Colors.black : Colors.white),
                ),
                myDivider(),
                const Spacer(
                  flex: 1,
                ),
                ...MenuItems.all.map(buildMenuItem).toList(),
                const Spacer(
                  flex: 2,
                ),
                SizedBox(
                  width: 130,
                  child: FlutterSwitch(
                    duration: const Duration(milliseconds: 500),
                    width: 120.0,
                    height: 45.0,
                    toggleSize: 40.0,
                    value: cubit.isDark,
                    borderRadius: 30.0,
                    activeToggleColor: Colors.blue,
                    inactiveToggleColor: Colors.grey,
                    activeSwitchBorder: Border.all(
                      color: const Color(0xFFD1D5DA),
                      width: 3.0,
                    ),
                    inactiveSwitchBorder: Border.all(
                      color: const Color(0xFF31125E),
                      width: 3.0,
                    ),
                    activeColor: Colors.white,
                    inactiveColor: const Color(0xFF0C0224),
                    activeIcon: const Icon(
                      Icons.wb_sunny,
                      color: Color(0xFFFFDF5D),
                    ),
                    inactiveIcon: const Icon(
                      Icons.nightlight_round,
                      color: Color(0xFFF8E3A1),
                    ),
                    onToggle: (val) {
                      cubit.changeMode();
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    navigateAndFinish(context, const LoginScreen());
                    logOut(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.power_settings_new_rounded,
                          size: 30,
                          color: cubit.isDark ? Colors.black : Colors.white),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Logout',
                        style: GoogleFonts.lobster(
                            fontSize: 30,
                            color: cubit.isDark ? Colors.black : Colors.white),
                      )
                    ],
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildMenuItem(Items item) => BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return ListTile(
            selected: currentItem == item,
            selectedTileColor: cubit.isDark ? Colors.white : Colors.black,
            minLeadingWidth: 10,
            leading: Icon(
              item.icon,
              color: cubit.isDark ? Colors.black : Colors.white,
              size: 26,
            ),
            title: Text(
              item.title,
              style: GoogleFonts.lobster(
                fontSize: 26,
                color: cubit.isDark ? Colors.black : Colors.white,
              ),
            ),
            onTap: () {
              onSelectedItem(item);
            },
          );
        },
      );
}
