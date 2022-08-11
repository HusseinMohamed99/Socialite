import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_app/Pages/chat/chatScreen.dart';
import 'package:f_app/Pages/drawer/drawerItem.dart';
import 'package:f_app/Pages/feed/feedscreen.dart';
import 'package:f_app/Pages/notifications/notifications_screen.dart';
import 'package:f_app/Pages/profile/My_profile_screen.dart';
import 'package:f_app/Pages/setting/settingScreen.dart';
import 'package:f_app/Pages/story/story_screen.dart';
import 'package:f_app/Pages/user/userScreen.dart';
import 'package:f_app/layout/Home/home_layout.dart';
import 'package:f_app/model/drawerModel.dart';
import 'package:f_app/model/user_model.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialState.dart';
import 'package:f_app/shared/componnetns/components.dart';
import 'package:f_app/shared/componnetns/constants.dart';
import 'package:f_app/shared/network/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../Pages/forgetPassword/forgetPasswordScreen.dart';
import '../../../Pages/save_post/save_post_screen.dart';



class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);

  // ----------------------------------------------------------//

///START : GetUserData
  UserModel? userModel;
  void getUserData() {
    emit(SocialGetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(SocialGetUserDataSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SocialGetUserDataErrorState(error.toString()));
    });
  }
///END : GetUserData

  // ----------------------------------------------------------//

///START : Screens
  int currentIndex = 0;
  List<Widget> screens =
  [
     FeedScreen(),
     ChatScreen(),
     UserScreen(),
     StoryScreen(),
     SettingScreen(),
  ];
///END : Screens

  // ----------------------------------------------------------//

///START : Titles
  List<String> titles =
  [
    'F-APP',
    'Chat Screen',
    'User Screen',
    'Story',
    'Setting Screen',
  ];
///END : Titles

  // ----------------------------------------------------------//

///START : Tabs
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
///END : Tabs

  // ----------------------------------------------------------//

///START : ChangeTabBar
  void changeTabBar(int index,context) {
    currentIndex = index;
    emit(SocialChangeTabBarState());
  }
///END : ChangeTabBar

  // ----------------------------------------------------------//

///START : ChangeItem(Drawer)
  Items currentItem = MenuItems.profile;
  void changeItem(Items item, context) {
    currentItem = item;
    getScreen(context);
    emit(ChangeMenuItemState());
  }
  Widget mScreen = const  MainScreen();
  void getScreen(context) {
    if (currentItem == MenuItems.profile) {
     navigateTo(context, MyProfileScreen());
      mScreen = const MainScreen();
    } else if (currentItem == MenuItems.notifications) {
      navigateTo(context, NotificationScreen());
      mScreen = const MainScreen();
    } else if (currentItem == MenuItems.savedPost) {
      navigateTo(context, SavePostScreen());
      mScreen =const  MainScreen();
    } else if (currentItem == MenuItems.restPassword) {
      navigateTo(context, RestPasswordScreen());
      mScreen =const  MainScreen();
    } else {
      mScreen = const MainScreen();
    }
    emit(ChangeMenuScreenState());
  }
///END : ChangeItem(Drawer)

  // ----------------------------------------------------------//

///START : ChangeMode
  bool isDark = true;
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
///END : ChaneMode

  // ----------------------------------------------------------//

///START : GetProfileImage
  var picker = ImagePicker();
  File? profileImage;
  Future <void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(GetProfileImagePickedSuccessState());
    }else{
      debugPrint('No image selected');
      emit(GetProfileImagePickedSuccessState());

    }
  }
///END : GetProfileImage

 // ----------------------------------------------------------//

///START : GetCoverImage
  File? coverImage;
  Future <void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(GetCoverImagePickedSuccessState());
    }else{
      debugPrint('No image selected');
      emit(GetCoverImagePickedSuccessState());

    }
  }
///END : GetCoverImage

  // ----------------------------------------------------------//

///START : UploadProfileImage

void uploadProfileImage({
  required String email,
  required String phone,
  required String name,
  required String bio,
})
{
  emit(UpdateUserLoadingState());
  firebase_storage.FirebaseStorage.instance
      .ref()
      .child('userProfileImage/${Uri.file(profileImage!.path).pathSegments.last}')
      .putFile(profileImage!)
      .then((value)
  {
    value.ref.getDownloadURL()
        .then((value)
    {
      updateUserData(
          email: email,
          phone: phone,
          name: name,
          bio: bio,
        image: value,
      );
     // emit(UploadProfileImageSuccessState());
    })
        .catchError((error)
    {
      emit(UploadProfileImageErrorState());
    });
  })
      .catchError((error)
  {
    emit(UploadProfileImageErrorState());
  });
}
///END : UploadProfileImage

// ----------------------------------------------------------//

///START : UploadCoverImage

  void uploadCoverImage({
    required String email,
    required String phone,
    required String name,
    required String bio,
  })
  {
    emit(UpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('userCoverImage/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value)
    {
      value.ref.getDownloadURL()
          .then((value)
      {
        updateUserData(
            email: email,
            phone: phone,
            name: name,
            bio: bio,
          cover: value,
        );
      //  emit(UploadCoverImageSuccessState());
      })
          .catchError((error)
      {
        emit(UploadCoverImageErrorState());
      });
    })
        .catchError((error)
    {
      emit(UploadCoverImageErrorState());
    });
  }
///END : UploadCoverImage

  // ----------------------------------------------------------//

  ///START : UploadProfileAndCoverImage

  void uploadProfileAndCoverImage({
    required String email,
    required String phone,
    required String name,
    required String bio,
  })
  {
    emit(UpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('userProfileImage/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value)
    {
      value.ref.getDownloadURL()
          .then((value)
      {
        updateUserData(
          email: email,
          phone: phone,
          name: name,
          bio: bio,
          image: value,
        );
        // emit(UploadProfileImageSuccessState());
      })
          .catchError((error)
      {
        emit(UploadProfileImageErrorState());
      });
    })
        .catchError((error)
    {
      emit(UploadProfileImageErrorState());
    });

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('userCoverImage/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value)
    {
      value.ref.getDownloadURL()
          .then((value)
      {
        updateUserData(
          email: email,
          phone: phone,
          name: name,
          bio: bio,
          cover: value,
        );
        //  emit(UploadCoverImageSuccessState());
      })
          .catchError((error)
      {
        emit(UploadCoverImageErrorState());
      });
    })
        .catchError((error)
    {
      emit(UploadCoverImageErrorState());
    });


  }
  ///END : UploadProfileAndCoverImage


// ----------------------------------------------------------//

///START : UpdateUserData
void updateUserData(
  {
  required String email,
  required String phone,
  required String name,
  required String bio,
  String? image,
  String? cover,
})
{
  emit(UpdateUserLoadingState());
    UserModel model = UserModel(
      email: email,
      phone: phone,
      name: name,
      bio: bio,
      cover:cover?? userModel!.cover,
      image:image?? userModel!.image,
      uId: userModel!.uId,
      isEmailVerified : false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value)
    {
      getUserData();
    }).catchError((error)
    {
      emit(UpdateUserErrorState());
    });


}
///END : UpdateUserData

// ----------------------------------------------------------//

}
