
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
import 'package:f_app/model/post_model.dart';
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
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetUserDataErrorState(error.toString()));
    });
  }
///END : GetUserData

  // ----------------------------------------------------------//

///START : Screens
  int currentIndex = 0;
  List<Widget> screens =
  [
     const FeedScreen(),
     const ChatScreen(),
     const UserScreen(),
     const StoryScreen(),
     const SettingScreen(),
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
     navigateTo(context, const MyProfileScreen());
      mScreen = const MainScreen();
    } else if (currentItem == MenuItems.notifications) {
      navigateTo(context, const NotificationScreen());
      mScreen = const MainScreen();
    } else if (currentItem == MenuItems.savedPost) {
      navigateTo(context, const SavePostScreen());
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
      emit(GetProfileImagePickedErrorState());

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
      emit(GetCoverImagePickedErrorState());

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



  ///START : GetPostImage
  File? postImage;
  Future <void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(GetPostImagePickedSuccessState());
    }else{
      debugPrint('No image selected');
      emit(GetPostImagePickedErrorState());

    }
  }
  ///END : GetPostImage

  // ----------------------------------------------------------//
  ///START : uploadPostImage

  void uploadPostImage({
    required  String dateTime,
    required  String text,
  })
  {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('postImage/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value)
    {
      value.ref.getDownloadURL()
          .then((value)
      {
        createPost(
            dateTime: dateTime,
            text: text,
          postImage: value,
        );

       emit(CreatePostSuccessState());
      })
          .catchError((error)
      {
        emit(CreatePostErrorState());
      });
    })
        .catchError((error)
    {
      emit(CreatePostErrorState());
    });
  }
///END : uploadPostImage

// ----------------------------------------------------------//

  ///START : CreatePost
  void createPost(
      {
        required  String dateTime,
        required  String text,
                  String? postImage,
      })
  {
    emit(CreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      text: text,
      postImage: postImage ?? '',
      dateTime: dateTime,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value)
    {
      emit(CreatePostSuccessState());
    }).catchError((error)
    {
      emit(CreatePostErrorState());
    });


  }
///END : CreatePost

// ----------------------------------------------------------//

///START : RemovePostImage
void removePostImage()
{
  postImage = null;
  emit(RemovePostImageSuccessState());
}

///END : RemovePostImage


// ----------------------------------------------------------//

///START : GetAllPosts
  List<PostModel> posts = [];
  PostModel? postModel;
  void getPosts()
  {
    posts.clear();
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime',descending: true)
        .get()
        .then((value)
    {
      for (var element in value.docs) {
        posts.add(PostModel.fromJson(element.data()));
      }
      emit(GetPostsSuccessState());
    }).catchError((error)
    {
      emit(GetPostsErrorState(error.toString()));
    });
  }

///END : GetAllPosts

// ----------------------------------------------------------//

List <PostModel>? userPosts =[];
  void getUserPosts(String? userID)
  {
   FirebaseFirestore.instance
       .collection('posts')
       .orderBy('dateTime')
       .snapshots()
       .listen((event)
   {
     userPosts=[];
     for (var element in event.docs) {
       if(element.data()['uId']==userID)
       {
         userPosts?.add(PostModel.fromJson(element.data()));
       }
     }
     emit(GetUserPostsSuccessState());
   });
  }

}
