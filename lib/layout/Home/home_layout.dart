import 'package:badges/badges.dart';
import 'package:f_app/Pages/notifications/notifications_screen.dart';
import 'package:f_app/Pages/search/search_screen.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialState.dart';
import 'package:f_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
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
              leading: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.menu,
                  color: cubit.isLight ? const Color(0xff404258) : Colors.white,
                ),
              ),
              titleSpacing: 0.0,
              title: Text(
                cubit.titles[cubit.currentIndex],
                style: GoogleFonts.roboto(
                  color: cubit.isLight ? Colors.blue : Colors.white,
                  fontSize: 24,
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
                  splashRadius: 20,
                  icon: Icon(
                    IconlyBroken.search,
                    color: cubit.isLight ? Colors.black : Colors.white,
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
                  splashRadius: 20,
                  icon: SocialCubit.get(context).unReadNotificationsCount != 0
                      ? tabBarBadge(
                          icon: IconlyBroken.notification,
                          count:
                              SocialCubit.get(context).unReadNotificationsCount)
                      : Icon(
                          IconlyBroken.notification,
                          color: cubit.isLight ? Colors.black : Colors.white,
                        ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomItems,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeTabBar(index);
              },
            ),
            body: cubit.screens[cubit.currentIndex]);
      },
    );
  }

  Widget tabBarBadge({required IconData icon, required int count}) {
    return Badge(
      badgeContent: Text('$count'),
      animationType: BadgeAnimationType.scale,
      child: Icon(icon),
    );
  }
}

// class MenuScreen extends StatelessWidget {
//   final ItemsModel currentItem;
//   final ValueChanged<ItemsModel> onSelectedItem;
//
//   const MenuScreen(
//       {Key? key, required this.currentItem, required this.onSelectedItem})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SocialCubit, SocialStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var cubit = SocialCubit.get(context);
//         var userModel = SocialCubit.get(context).userModel!;
//         return SocialCubit.get(context).userModel == null
//             ? Scaffold(
//                 body: Column(
//                   children: [
//                     const Icon(
//                       IconlyLight.infoSquare,
//                       size: 100,
//                       color: Colors.grey,
//                     ),
//                     Text(
//                       'No Posts yet',
//                       style: GoogleFonts.libreBaskerville(
//                         fontWeight: FontWeight.w700,
//                         fontSize: 30,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ))
//             : SafeArea(
//                 child: Scaffold(
//                   resizeToAvoidBottomInset: false,
//                   extendBody: true,
//                   body: Column(
//                     children: [
//                       SizedBox(
//                         height: 240,
//                         child: Stack(
//                           alignment: AlignmentDirectional.bottomCenter,
//                           children: [
//                             Align(
//                               alignment: AlignmentDirectional.topCenter,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                       fit: BoxFit.cover,
//                                       image: NetworkImage('${userModel.cover}'),
//                                     ),
//                                     borderRadius: const BorderRadius.only(
//                                       topLeft: Radius.circular(8.0),
//                                       topRight: Radius.circular(8.0),
//                                     )),
//                                 width: double.infinity,
//                                 height: 200,
//                               ),
//                             ),
//                             CircleAvatar(
//                               backgroundColor: Colors.white,
//                               radius: 65,
//                               child: CircleAvatar(
//                                 backgroundImage: NetworkImage(
//                                   '${userModel.image}',
//                                 ),
//                                 radius: 60,
//                               ),
//                             ),
//                             Positioned(
//                               top: 60,
//                               right: 5,
//                               child: IconButton(
//                                 onPressed: () {
//                                   ZoomDrawer.of(context)!.close();
//                                 },
//                                 icon: const CircleAvatar(
//                                   backgroundColor: Colors.black,
//                                   child: Icon(
//                                     IconlyLight.arrowRight2,
//                                     size: 30,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Text(
//                         '${userModel.name}',
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.roboto(
//                             fontSize: 30,
//                             color: cubit.isLight ? Colors.black : Colors.white),
//                       ),
//                       myDivider(Colors.grey),
//                       space(0, 15),
//                       ...MenuItems.all.map(buildMenuItem).toList(),
//                       const Spacer(
//                         flex: 6,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               width: 130,
//                               child: FlutterSwitch(
//                                 duration: const Duration(milliseconds: 500),
//                                 width: 120.0,
//                                 height: 45.0,
//                                 toggleSize: 40.0,
//                                 value: cubit.isLight,
//                                 borderRadius: 30.0,
//                                 activeToggleColor: Colors.blue,
//                                 inactiveToggleColor: Colors.grey,
//                                 activeSwitchBorder: Border.all(
//                                   color: const Color(0xFFD1D5DA),
//                                   width: 3.0,
//                                 ),
//                                 inactiveSwitchBorder: Border.all(
//                                   color: const Color(0xFF31125E),
//                                   width: 3.0,
//                                 ),
//                                 activeColor: Colors.white,
//                                 inactiveColor: const Color(0xFF0C0224),
//                                 activeIcon: const Icon(
//                                   Icons.wb_sunny,
//                                   color: Color(0xFFFFDF5D),
//                                 ),
//                                 inactiveIcon: const Icon(
//                                   Icons.nightlight_round,
//                                   color: Color(0xFFF8E3A1),
//                                 ),
//                                 onToggle: (val) {
//                                   cubit.changeMode();
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       space(0, 10),
//                       InkWell(
//                         onTap: () {
//                           logOut(context);
//                           FirebaseAuth.instance.signOut();
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                           child: Row(
//                             children: [
//                               Icon(Icons.power_settings_new_rounded,
//                                   size: 30,
//                                   color: cubit.isLight
//                                       ? Colors.black
//                                       : Colors.white),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 'Logout',
//                                 style: GoogleFonts.roboto(
//                                     fontSize: 30,
//                                     color: cubit.isLight
//                                         ? Colors.black
//                                         : Colors.white),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const Spacer(
//                         flex: 1,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//       },
//     );
//   }
//
//   Widget buildMenuItem(ItemsModel item) => BlocConsumer<SocialCubit, SocialStates>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           var cubit = SocialCubit.get(context);
//           return SocialCubit.get(context).userModel == null
//               ? Center(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Icon(
//                         IconlyLight.infoSquare,
//                         size: 100,
//                         color: Colors.grey,
//                       ),
//                       Text(
//                         'No Posts yet',
//                         style: GoogleFonts.libreBaskerville(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 30,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               : Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: ListTile(
//                     selected: currentItem == item,
//                     selectedTileColor:
//                         cubit.isLight ? Colors.white : Colors.black,
//                     minLeadingWidth: 10,
//                     leading: Icon(
//                       item.icon,
//                       color: cubit.isLight ? Colors.black : Colors.white,
//                       size: 26,
//                     ),
//                     title: Text(
//                       item.title,
//                       style: GoogleFonts.roboto(
//                         fontSize: 26,
//                         color: cubit.isLight ? Colors.black : Colors.white,
//                       ),
//                     ),
//                     onTap: () {
//                       onSelectedItem(item);
//                     },
//                   ),
//                 );
//         },
//       );
// }
