import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_app/Pages/chat/chatScreen.dart';
import 'package:f_app/Pages/feed/feedscreen.dart';
import 'package:f_app/Pages/notifications/notifications_screen.dart';
import 'package:f_app/Pages/profile/My_profile_screen.dart';
import 'package:f_app/Pages/setting/settingScreen.dart';
import 'package:f_app/Pages/story/story_screen.dart';
import 'package:f_app/Pages/user/userScreen.dart';
import 'package:f_app/layout/Home/home_layout.dart';
import 'package:f_app/model/CommentModel.dart';
import 'package:f_app/model/drawerModel.dart';
import 'package:f_app/model/messageModel.dart';
import 'package:f_app/model/post_model.dart';
import 'package:f_app/model/user_model.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialState.dart';
import 'package:f_app/shared/componnetns/components.dart';
import 'package:f_app/shared/componnetns/constants.dart';
import 'package:f_app/shared/network/cache_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:f_app/Pages/password/forget_Password.dart';
import '../../../Pages/on-boarding/on-boarding screen.dart';
import '../../../Pages/post/save_post_screen.dart';
import '../../../layout/drawer/drawerItem.dart';
import '../../../model/likesModel.dart';

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
  ///START : GetAllUsers
  List<UserModel> users = [];
  void getAllUsers() {
    emit(GetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((event) {
      users = [];
      for (var element in event.docs) {
        if (element.data()['uId'] != userModel!.uId) {
          users.add(UserModel.fromJson(element.data()));
        }
      }
      emit(GetAllUsersSuccessState());
    }).catchError((error) {
      emit(GetAllUsersErrorState(error.toString()));
    });
  }

  ///END : GetAllUsers

  // ----------------------------------------------------------//
  ///START : Screens
  int currentIndex = 0;
  List<Widget> screens = [
    const FeedScreen(),
    const ChatScreen(),
    const UserScreen(),
    const StoryScreen(),
    const SettingScreen(),
  ];

  ///END : Screens

  // ----------------------------------------------------------//

  ///START : Titles
  List<String> titles = [
    'F-APP',
    'Chat Screen',
    'User Screen',
    'Story',
    'Setting Screen',
  ];

  ///END : Titles

  // ----------------------------------------------------------//

  ///START : Tabs
  List<Widget> tabs = [
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
  void changeTabBar(int index, context) {
    if (index == 1) {
      getAllUsers();
    }
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

  Widget mScreen = const MainScreen();
  void getScreen(context) {
    if (currentItem == MenuItems.profile) {
      navigateTo(context, const MyProfileScreen());
      mScreen = const MainScreen();
    } else if (currentItem == MenuItems.notifications) {
      navigateTo(context, const NotificationScreen());
      mScreen = const MainScreen();
    } else if (currentItem == MenuItems.savedPost) {
      navigateTo(context, const SavePostScreen());
      mScreen = const MainScreen();
    } else if (currentItem == MenuItems.restPassword) {
      navigateTo(context, RestPasswordScreen());
      mScreen = const MainScreen();
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

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(GetProfileImagePickedSuccessState());
    } else {
      debugPrint('No image selected');
      emit(GetProfileImagePickedErrorState());
    }
  }

  ///END : GetProfileImage

  // ----------------------------------------------------------//

  ///START : GetCoverImage
  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(GetCoverImagePickedSuccessState());
    } else {
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
  }) {
    emit(UpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'userProfileImage/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(
          email: email,
          phone: phone,
          name: name,
          bio: bio,
          image: value,
        );
        // emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
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
  }) {
    emit(UpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('userCoverImage/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(
          email: email,
          phone: phone,
          name: name,
          bio: bio,
          cover: value,
        );
        //  emit(UploadCoverImageSuccessState());
      }).catchError((error) {
        emit(UploadCoverImageErrorState());
      });
    }).catchError((error) {
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
  }) {
    emit(UpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'userProfileImage/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(
          email: email,
          phone: phone,
          name: name,
          bio: bio,
          image: value,
        );
        // emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('userCoverImage/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(
          email: email,
          phone: phone,
          name: name,
          bio: bio,
          cover: value,
        );
        //  emit(UploadCoverImageSuccessState());
      }).catchError((error) {
        emit(UploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState());
    });
  }

  ///END : UploadProfileAndCoverImage

// ----------------------------------------------------------//

  ///START : UpdateUserData
  void updateUserData({
    required String email,
    required String phone,
    required String name,
    required String bio,
    String? image,
    String? cover,
  }) {
    emit(UpdateUserLoadingState());
    UserModel model = UserModel(
      email: email,
      phone: phone,
      name: name,
      bio: bio,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
      uId: userModel!.uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UpdateUserErrorState());
    });
  }

  ///END : UpdateUserData

// ----------------------------------------------------------//
  ///START : GetPostImage
  File? postImagePicked;
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImagePicked = File(pickedFile.path);
      emit(GetPostImagePickedSuccessState());
    } else {
      debugPrint('No image selected');
      emit(GetPostImagePickedErrorState());
    }
  }

  ///END : GetPostImage

  // ----------------------------------------------------------//
  ///START : uploadPostImage
  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('postImage/${Uri.file(postImagePicked!.path).pathSegments.last}')
        .putFile(postImagePicked!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );

        emit(CreatePostSuccessState());
      }).catchError((error) {
        emit(CreatePostErrorState());
      });
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  ///END : uploadPostImage

// ----------------------------------------------------------//

  ///START : CreatePost
  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      text: text,
      postImage: postImage ?? '',
      dateTime: dateTime,
      postID: null,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  ///END : CreatePost

// ----------------------------------------------------------//

  ///START : RemovePostImage
  void removePostImage() {
    postImagePicked = null;

    emit(RemovePostImageSuccessState());
  }

  ///END : RemovePostImage

// ----------------------------------------------------------//

  ///START : GetAllPosts
  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<bool> likedByMe = [];
  List<int> commentsNum = [];
  PostModel? postModel;
  int counter = 0;
  int commentCounter = 0;
  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      posts = [];
      likes = [];
      postsId = [];
      likedByMe = [];
      commentsNum = [];
      counter = 0;
      commentCounter = 0;
      for (var element in event.docs) {
        element.reference.collection('likes').get().then((value) {
          emit(GetPostsSuccessState());
          likes.add(value.docs.length);
          for (var element in value.docs) {
            if (element.id == userModel!.uId) {
              counter++;
            }
          }
          if (counter > 0) {
            likedByMe.add(true);
          } else {
            likedByMe.add(false);
          }
          counter = 0;
        }).catchError((error) {
          emit(GetPostsErrorState(error.toString()));
        });
        element.reference.collection('comments').get().then((value) {
          emit(GetPostsSuccessState());
          commentsNum.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          for (var element in value.docs) {
            if (element.id == userModel!.uId) {
              commentCounter++;
            } else {
              commentCounter++;
            }
            commentCounter = 0;
          }
        }).catchError((error) {});
      }

      emit(GetPostsSuccessState());
    });
  }

  ///END : GetAllPosts

// ----------------------------------------------------------//
  ///START : GetMyPosts
  List<PostModel>? userPosts = [];
  void getMyPosts(String? userID) {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      userPosts = [];
      for (var element in event.docs) {
        if (element.data()['uId'] == userID) {
          userPosts?.add(PostModel.fromJson(element.data()));
        }
      }
      emit(GetUserPostsSuccessState());
    });
  }

  ///END : GetMyPosts

// ----------------------------------------------------------//
  ///START : Likes
  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(LikesSuccessState());
    }).catchError((error) {
      emit(LikesErrorState(error.toString()));
    });
  }

  ///END : Likes

// ----------------------------------------------------------//
  ///START : DisLikes
  void disLikePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .delete()
        .then((value) {
      emit(DisLikesSuccessState());
    }).catchError((error) {
      emit(DisLikesErrorState(error.toString()));
    });
  }

  ///END : DisLikes

//-----------------------------------------------------------//
  ///START : WhoLikes
  List<LikesModel> peopleReacted = [];
  void getLikes(
    String? postId,
  ) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .orderBy('dateTime', descending: false)
        .snapshots()
        .listen((value) {
      peopleReacted = [];
      for (var element in value.docs) {
        peopleReacted.add(LikesModel.fromJson(element.data()));
      }
      emit(GetLikedUsersSuccessState());
    });
  }

  ///END : WhoLikes

// ----------------------------------------------------------//
  ///END : GetComments
  List<CommentModel> comments = [];
  void getComments(
    String? postId,
  ) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('dateTime', descending: false)
        .snapshots()
        .listen((event) {
      comments = [];
      for (var element in event.docs) {
        comments.add(CommentModel.fromJson(element.data()));
      }
    });
    emit(GetCommentsSuccessState());
  }

  ///END : GetComments

// ----------------------------------------------------------//

  ///START : SendComment
  CommentModel? comment;
  void sendComment({
    String? dateTime,
    String? text,
    String? postId,
  }) {
    CommentModel comment = CommentModel(
        dateTime: dateTime,
        uId: userModel!.uId,
        comment: text,
        image: userModel!.image,
        name: userModel!.name);

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(comment.toMap())
        .then((value) {
      emit(SendCommentSuccessState());
    }).catchError((error) {
      emit(SendCommentErrorState());
      debugPrint(error.toString());
    });
  }

  ///END : SendComment

// ----------------------------------------------------------//
  ///START : SaveToGallery
  void saveToGallery(String imageUrl) {
    emit(SavedToGalleryLoadingState());
    GallerySaver.saveImage(imageUrl, albumName: 'F-APP').then((value) {
      emit(SavedToGallerySuccessState());
    }).catchError((error) {
      debugPrint("${error.toString()} from saveToGallery");
      emit(SavedToGalleryErrorState());
    });
  }

  ///END : SaveToGallery

// ----------------------------------------------------------//
  ///START : EditPost
  void editPost(
      {required String dateTime,
      required PostModel postModel,
      required String postId,
      required String text,
      String? postImage}) {
    emit(EditPostLoadingState());
    postModel = PostModel(
        uId: postModel.uId,
        name: postModel.name,
        image: postModel.image,
        dateTime: postModel.dateTime,
        likes: postModel.likes,
        myLike: postModel.myLike,
        likesNum: postModel.likesNum,
        comments: postModel.comments,
        commentsNum: postModel.commentsNum,
        commentsName: postModel.commentsName,
        commentsImage: postModel.commentsImage,
        text: text,
        postImage: postImage ?? postModel.postImage);
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .update(postModel.toMap())
        .then((value) {
      emit(EditPostSuccessState());
    }).catchError((error) {
      debugPrint("${error.toString()} from urlUpdatePost");
      emit(EditPostErrorState());
    });
  }

  ///END : EditPost

// ----------------------------------------------------------//
  ///START : EditPostWithImage
  void editPostWithImage({
    required String dateTime,
    required PostModel postModel,
    required String postId,
    required String text,
    String? postImage,
  }) {
    emit(EditPostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'editedPosts/${Uri.file(postImagePicked!.path).pathSegments.last}')
        .putFile(postImagePicked!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        editPost(
          postModel: postModel,
          postId: postId,
          text: text,
          postImage: value,
          dateTime: dateTime,
        );
      }).catchError((error) {
        debugPrint("${error.toString()} from urlUpdatePost");
        emit(EditPostErrorState());
      });
    }).catchError((error) {
      debugPrint("${error.toString()} from urlUpdatePost");
      emit(EditPostErrorState());
    });
  }

  ///END : EditPostWithImage

// ----------------------------------------------------------//
  ///START : DeleteAccount
  void deleteAccount(context) async {
    await FirebaseAuth.instance.currentUser!.delete().then((value) async {
      await FirebaseFirestore.instance.collection('users').doc(uId).delete();
      CacheHelper.removeData(key: 'uId');
      navigateAndFinish(context, const OnBoard());
    });
  }

  ///END : DeleteAccount

// ----------------------------------------------------------//
  ///START : DeletePost
  void deletePost(String? postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .delete()
        .then((value) {
      showToast(text: 'Post Deleted', state: ToastStates.success);
      emit(DeletePostSuccessState());
    });
  }

  ///END : DeletePost

// ----------------------------------------------------------//
  ///START : ChangeUserPassword
  void changeUserPassword({
    required String password,
  }) {
    emit(ChangeUserPasswordLoadingState());
    FirebaseAuth.instance.currentUser?.updatePassword(password).then((value) {
      showToast(
        state: ToastStates.success,
        text: 'Change Successful',
      );
      emit(ChangeUserPasswordSuccessState());
      getUserData();
    }).catchError((error) {
      showToast(
        state: ToastStates.error,
        text: 'process failed\nYou Should Re-login Before Change Password',
      );
      emit(ChangeUserPasswordErrorState(error.toString()));
      debugPrint(error.toString());
    });
  }

  ///END : ChangeUserPassword

// ----------------------------------------------------------//
  ///START : Show Password
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void showPassword() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShowPasswordState());
  }

  ///END : Show Password

//------------------------------------------------------------//
  ///START : Show Password
  MessageModel? messageModel;
  void sendMessage({

    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      receiverId: receiverId,
      dateTime: dateTime,
      text: text,
      senderId: userModel!.uId,
    );

    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel!.uId)
    .collection('chat')
    .doc(receiverId)
    .collection('message')
    .add(model.toMap())
        .then((value)
    {
      emit(SendCommentSuccessState());
    }).catchError((error)
    {
      emit(SendCommentErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(userModel!.uId)
        .collection('message')
        .add(model.toMap())
        .then((value)
    {
      emit(SendCommentSuccessState());
    }).catchError((error)
    {
      emit(SendCommentErrorState());
    });
  }

  ///END : Show Password

//------------------------------------------------------------//
///START : Show Password
List<MessageModel> message = [];
  void getMessage({
    required String receiverId,
})
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chat')
        .doc(receiverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      message = [];
      event.docs.forEach((element)
      {
       message.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessageSuccessState());
    });
  }
///END : Show Password

//------------------------------------------------------------//


//------------------------------------------------------------//


//------------------------------------------------------------//

//------------------------------------------------------------//

}
