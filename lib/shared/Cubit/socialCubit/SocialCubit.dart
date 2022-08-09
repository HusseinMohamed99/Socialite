import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_app/Pages/chat/chatScreen.dart';
import 'package:f_app/Pages/drawer/drawerItem.dart';
import 'package:f_app/Pages/feed/feedscreen.dart';
import 'package:f_app/Pages/setting/settingScreen.dart';
import 'package:f_app/Pages/story/story_screen.dart';
import 'package:f_app/Pages/user/userScreen.dart';
import 'package:f_app/layout/Home/home_layout.dart';
import 'package:f_app/model/drawerModel.dart';
import 'package:f_app/model/user_model.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialState.dart';
import 'package:f_app/shared/componnetns/constants.dart';
import 'package:f_app/shared/network/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';



class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());


  static SocialCubit get(context) => BlocProvider.of(context);

  ///START : GetUserData
  UserModel? model;

  void getUserData() {
    emit(SocialGetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = UserModel.fromJson(value.data()!);
      emit(SocialGetUserDataSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SocialGetUserDataErrorState(error.toString()));
    });
  }
  ///END : GetUserData

  int currentIndex = 0;
  List<Widget> screens =
  [
    const FeedScreen(),
    const ChatScreen(),
    const UserScreen(),
    const StoryScreen(),
    const SettingScreen(),
  ];

  List<String> titles =
  [
    'F-APP',
    'Chat Screen',
    'User Screen',
    'Story',
    'Setting Screen',
  ];

  List<Widget> tabs =
  [
    const Tab(
      icon: Icon(
        IconlyBroken.home,
        size: 30,
      ),
    ),
    const Tab(
      icon: Icon(
        IconlyBroken.activity,
        size: 30,
      ),
    ),
    const Tab(
      icon: Icon(
        IconlyBroken.addUser,
        size: 30,
      ),
    ),
    const Tab(
      icon: Icon(
        IconlyBroken.discovery,
        size: 30,
      ),
    ),
    const Tab(
      icon: Icon(
        IconlyBroken.setting,
        size: 30,
      ),
    ),
  ];



  void changeTabBar(int index,context) {
    currentIndex = index;
    emit(SocialChangeTabBarState());
  }

  Items currentItem = MenuItems.profile;
  void changeItem(Items item, context) {
    currentItem = item;
    getScreen(context);
    emit(ChangeMenuItemState());
  }
  Widget mScreen = const  MainScreen();
  void getScreen(context) {
    if (currentItem == MenuItems.profile) {
      changeTabBar(0, context);
      mScreen = const MainScreen();
    } else if (currentItem == MenuItems.notifications) {
      changeTabBar(1, context);
      mScreen = const MainScreen();
    } else if (currentItem == MenuItems.savedPost) {
      changeTabBar(2, context);
      mScreen =const  MainScreen();
    } else if (currentItem == MenuItems.restPassword) {
      changeTabBar(3, context);
      mScreen =const  MainScreen();
    } else {
      mScreen = const MainScreen();
    }
    emit(ChangeMenuScreenState());
  }

  bool isDark = false;
  Color backgroundColor = Colors.white;
  void changeMode({bool? fromShared}) {
    if (fromShared == null) {
      isDark = !isDark;
    } else {
      isDark = fromShared;
    }
    CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
      if (isDark) {
        backgroundColor = Colors.white;

        emit(ChangeThemeState());
      } else {
        backgroundColor = HexColor('#212121').withOpacity(0.8);
        emit(ChangeThemeState());
      }
      emit(ChangeThemeState());
    });
  }
}
