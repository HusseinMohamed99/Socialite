import 'package:f_app/Pages/drawer/drawerItem.dart';
import 'package:f_app/model/drawerModel.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialState.dart';
import 'package:f_app/shared/componnetns/components.dart';
import 'package:f_app/shared/componnetns/constants.dart';
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
      listener: (context, state)
      {

      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return SocialCubit.get(context).userModel == null
            ? Scaffold(
            backgroundColor:
            cubit.isDark ? Colors.white : const Color(0xff063750),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    IconlyLight.infoSquare,
                    size: 100,
                    color: Colors.grey,
                  ),
                  Text(
                    'No Posts yet',
                    style: GoogleFonts.libreBaskerville(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: Colors.grey,
                    ),
                  ),
                  space(0, 20),
                  TextButton.icon(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all
                          (
                            cubit.isDark? Colors.blue : Colors.white
                        )
                    ),
                    onPressed: ()
                    {
                      SocialCubit.get(context).getUserData();
                    },
                    icon: Icon(
                      IconlyLight.upload,
                      color: cubit.isDark? Colors.white : Colors.blue,
                    ),
                    label:  Text(
                      'Reload',
                      style: GoogleFonts.libreBaskerville(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: cubit.isDark? Colors.white : Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
            )):
          ZoomDrawer(
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
          menuBackgroundColor:
              cubit.isDark ? const Color(0xff063750) : Colors.white,
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
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: cubit.isDark ?  Colors.white : const Color(0xff063750),
                statusBarIconBrightness:cubit.isDark ? Brightness.dark : Brightness.light,
                statusBarBrightness: cubit.isDark ? Brightness.dark : Brightness.light,
              ),
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
            body: SocialCubit.get(context).userModel == null
                ? Scaffold(
                backgroundColor:
                cubit.isDark ? Colors.white : const Color(0xff063750),
                body: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        IconlyLight.infoSquare,
                        size: 100,
                        color: Colors.grey,
                      ),
                      Text(
                        'No Posts yet',
                        style: GoogleFonts.libreBaskerville(
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                          color: Colors.grey,
                        ),
                      ),
                      space(0, 20),
                      TextButton.icon(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all
                              (
                                cubit.isDark? Colors.blue : Colors.white
                            )
                        ),
                        onPressed: ()
                        {
                          SocialCubit.get(context).getUserData();
                        },
                        icon: Icon(
                          IconlyLight.upload,
                          color: cubit.isDark? Colors.white : Colors.blue,
                        ),
                        label:  Text(
                          'Reload',
                          style: GoogleFonts.libreBaskerville(
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                            color: cubit.isDark? Colors.white : Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                )):
            cubit.screens[cubit.currentIndex],
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
        var userModel = SocialCubit.get(context).userModel!;
        return SocialCubit.get(context).userModel == null
            ? Scaffold(
            backgroundColor:
            cubit.isDark ? Colors.white : const Color(0xff063750),
            body: Column(
              children: [
                const Icon(
                  IconlyLight.infoSquare,
                  size: 100,
                  color: Colors.grey,
                ),
                Text(
                  'No Posts yet',
                  style: GoogleFonts.libreBaskerville(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    color: Colors.grey,
                  ),
                ),
              ],
            )):
          SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            backgroundColor:
              cubit.isDark ? Colors.white : const Color(0xff063750),
            body: Column(
              children: [
                SizedBox(
                  height: 240,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          decoration:  BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    '${userModel.cover}'
                                ),
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft:  Radius.circular(8.0),
                                topRight:  Radius.circular(8.0),
                              )),
                          width: double.infinity,
                          height: 200,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 65,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            '${userModel.image}',
                          ),
                          radius: 60,
                        ),
                      ),
                      Positioned(
                        top: 60,
                        left: 5,
                        child: IconButton(
                          onPressed: ()
                          {
                           ZoomDrawer.of(context)!.close();
                          },
                          icon: const CircleAvatar(
                            backgroundColor:  Colors.black,
                            child: Icon(
                              IconlyLight.arrowLeft2,
                              size: 30,
                              color: Colors.white,

                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${userModel.name}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lobster(
                      fontSize: 30,
                      color: cubit.isDark ? Colors.black : Colors.white),
                ),
                myDivider(),
                space(0, 15),
                ...MenuItems.all.map(buildMenuItem).toList(),
                const Spacer(
                  flex: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                    ],
                  ),
                ),
                space(0, 10),
                InkWell(
                  onTap: () {
                    logOut(context);
                    FirebaseAuth.instance.signOut();

                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                        ),
                      ],
                    ),
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
          return SocialCubit.get(context).userModel == null
              ?  Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      IconlyLight.infoSquare,
                      size: 100,
                      color: Colors.grey,
                    ),
                    Text(
                      'No Posts yet',
                      style: GoogleFonts.libreBaskerville(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
              : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListTile(
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
            ),
          );
        },
      );
}
