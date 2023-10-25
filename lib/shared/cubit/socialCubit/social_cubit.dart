import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socialite/pages/chat/chat_screen.dart';
import 'package:socialite/pages/feed/feed_screen.dart';
import 'package:socialite/pages/on-boarding/on_boarding_screen.dart';
import 'package:socialite/pages/setting/setting_screen.dart';
import 'package:socialite/pages/user/users_screen.dart';
import 'package:socialite/model/comment_model.dart';
import 'package:socialite/model/likes_model.dart';
import 'package:socialite/model/message_model.dart';
import 'package:socialite/model/notifications_model.dart';
import 'package:socialite/model/post_model.dart';
import 'package:socialite/model/story_model.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/pages/story/stories_screen.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/components/show_toast.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:socialite/shared/network/cache_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:socialite/shared/network/dio_helper.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:http/http.dart' as http;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = const [
    FeedScreen(),
    ChatScreen(),
    UserScreen(),
    StoryScreen(),
    SettingScreen(),
  ];
  List<BottomNavigationBarItem> bottomNavigationBarItem = const [
    BottomNavigationBarItem(icon: Icon(IconlyBroken.home), label: ''),
    BottomNavigationBarItem(icon: Icon(IconlyBroken.message), label: ''),
    BottomNavigationBarItem(icon: Icon(IconlyBroken.user3), label: ''),
    BottomNavigationBarItem(icon: Icon(IconlyBroken.upload), label: ''),
    BottomNavigationBarItem(icon: Icon(IconlyBroken.setting), label: ''),
  ];

  List<String> titles = [
    AppString.feed,
    AppString.chat,
    AppString.user,
    AppString.story,
    AppString.setting,
  ];

  void changeNavBar(int index) {
    currentIndex = index;
    if (index == 0) {
      getUserData();
      getStories();
      getPosts();
      getUserPosts(uId);
      getFriends(userModel!.uId);
      getFriendsProfile(userModel!.uId);
      getFriendRequest();
      checkFriends(userModel!.uId);
      checkFriendRequest(userModel!.uId);
    }
    if (index == 1) {
      getAllUsers();
    }
    if (index == 2) {
      getFriends(userModel!.uId);
      getFriendRequest();
      checkFriends(userModel!.uId);
      checkFriendRequest(userModel!.uId);
    }
    if (index == 3) {
      getStories();
      getUserStories(userModel!.uId);
    }
    if (index == 4) {
      getUserData();
    }
    emit(SocialChangeTabBarState());
  }

  UserModel? userModel;
  void getUserData() async {
    emit(GetUserDataLoadingState());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data()!);

      setUserToken();
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUserDataErrorState(error.toString()));
    });
  }

  List<UserModel> users = [];
  void getAllUsers() {
    emit(GetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((event) {
      users = [];
      for (var element in event.docs) {
        if (element.data()['uId'] != uId) {
          users.add(UserModel.fromJson(element.data()));
        }
      }
      emit(GetAllUsersSuccessState());
    }).catchError((error) {
      emit(GetAllUsersErrorState(error.toString()));
    });
  }

  void setUserToken() async {
    emit(SetUSerTokenLoadingState());
    String? token = await FirebaseMessaging.instance.getToken();
    debugPrint(' token $token');
    await FirebaseFirestore.instance.collection('users').doc(uId).update(
        {'token': token}).then((value) => emit(SetUSerTokenSuccessState()));
  }

  bool isDark = false;
  Color backgroundColor = ColorManager.titanWithColor;

  void changeAppMode({bool? fromShared}) {
    if (fromShared == null) {
      isDark = !isDark;
    } else {
      isDark = fromShared;
    }
    CacheHelper.putBoolean(key: AppString.isDark, value: isDark).then((value) {
      if (isDark) {
        backgroundColor = ColorManager.primaryDarkColor;
        emit(ChangeThemeState());
      } else {
        backgroundColor = Colors.white;
        emit(ChangeThemeState());
      }
      emit(ChangeThemeState());
    });
  }

  var picker = ImagePicker();
  File? profileImage;

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      profileImage = await cropImage(imageFile: profileImage!);
      emit(GetProfileImagePickedSuccessState());
    } else {
      debugPrint('No image selected');
      emit(GetProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      coverImage = await cropImage(imageFile: coverImage!);
      emit(GetCoverImagePickedSuccessState());
    } else {
      emit(GetCoverImagePickedErrorState());
    }
  }

  Future<File?> cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage != null) {
      return File(croppedImage.path);
    }
    return null;
  }

  void uploadProfileImage({
    required String email,
    required String phone,
    required String name,
    required String bio,
    required String portfolio,
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
          portfolio: portfolio,
        );
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String email,
    required String phone,
    required String name,
    required String bio,
    required String portfolio,
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
          portfolio: portfolio,
        );
      }).catchError((error) {
        emit(UploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState());
    });
  }

  void uploadProfileAndCoverImage({
    required String email,
    required String phone,
    required String name,
    required String bio,
    required String portfolio,
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
          portfolio: portfolio,
        );
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
          portfolio: portfolio,
        );
      }).catchError((error) {
        emit(UploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState());
    });
  }

  void updateUserData({
    required String email,
    required String phone,
    required String name,
    required String bio,
    required String portfolio,
    String? image,
    String? cover,
  }) {
    emit(UpdateUserLoadingState());
    UserModel model = UserModel(
      email: email,
      phone: phone,
      name: name,
      bio: bio,
      portfolio: portfolio,
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
      emit(UpdateUserSuccessState());
      getUserData();
    }).catchError((error) {
      emit(UpdateUserErrorState());
    });
  }

  File? postImagePicked;
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImagePicked = File(pickedFile.path);
      emit(GetPostImagePickedSuccessState());
    } else {
      emit(GetPostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    required DateTime dateTime,
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

  void createPost({
    required DateTime dateTime,
    required String text,
    String? postImage,
    String? profileImage,
    String? userName,
  }) {
    emit(CreatePostLoadingState());

    PostModel model = PostModel(
      uId: userModel!.uId,
      image: userModel!.image,
      name: userModel!.name,
      text: text,
      postImage: postImage ?? '',
      dateTime: dateTime,
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

  void removePostImage() {
    postImagePicked = null;

    emit(RemovePostImageSuccessState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> commentsNum = [];
  PostModel? postModel;

  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) async {
      posts = [];
      event.docs.forEach((element) async {
        posts.add(PostModel.fromJson(element.data()));
        postsId.add(element.id);
        var likes = await element.reference.collection('likes').get();
        var comments = await element.reference.collection('comments').get();
        commentsNum.add(element.id.length);
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(element.id)
            .update({
          'likes': likes.docs.length,
          'comments': comments.docs.length,
          'postId': element.id,
        });
      });
      emit(GetPostsSuccessState());
    });
  }

  List<PostModel> userPosts = [];
  void getUserPosts(String? userID) {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      userPosts = [];
      for (var element in event.docs) {
        if (element.data()['uId'] == userID) {
          userPosts.add(PostModel.fromJson(element.data()));
        }
      }
      emit(GetUserPostsSuccessState());
    });
  }

  Future<bool> likeByMe({
    context,
    String? postId,
    PostModel? postModel,
    UserModel? postUser,
    required DateTime dataTime,
  }) async {
    emit(LikedByMeCheckedLoadingState());
    bool isLikedByMe = false;
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .get()
        .then((event) async {
      var likes = await event.reference.collection('likes').get();
      for (var element in likes.docs) {
        if (element.id == userModel!.uId) {
          isLikedByMe = true;
          disLikePost(postId!);
        }
      }
      if (isLikedByMe == false) {
        likePosts(
          postId: postId,
          context: context,
          postModel: postModel,
          postUser: postUser,
          dateTime: dataTime,
        );
      }
      emit(LikedByMeCheckedSuccessState());
    });
    return isLikedByMe;
  }

  void likePosts({
    context,
    String? postId,
    PostModel? postModel,
    UserModel? postUser,
    required DateTime dateTime,
  }) {
    LikesModel likesModel = LikesModel(
      uId: userModel!.uId,
      name: userModel!.name,
      image: userModel!.image,
      dateTime: dateTime,
      bio: userModel!.bio,
      cover: userModel!.cover,
      email: userModel!.email,
      phone: userModel!.phone,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set(likesModel.toMap())
        .then((value) {
      getPosts();
      if (postModel!.uId != userModel!.uId) {
        SocialCubit.get(context).sendInAppNotification(
          receiverName: postModel.name,
          receiverId: postModel.uId,
          contentId: userModel!.uId,
          contentKey: AppString.likePost,
          content: AppString.likePost,
        );
        SocialCubit.get(context).sendFCMNotification(
          token: userModel!.token,
          senderName: userModel!.name,
          messageText: '${userModel!.name}'
              '${AppString.likePost}',
        );
      }
      emit(LikesSuccessState());
    }).catchError((error) {
      emit(LikesErrorState(error.toString()));
    });
  }

  void disLikePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .delete()
        .then((value) {
      getPosts();
      emit(DisLikesSuccessState());
    }).catchError((error) {
      emit(DisLikesErrorState(error.toString()));
    });
  }

  List<LikesModel> peopleReacted = [];
  void getLikes(
    String? postId,
  ) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .snapshots()
        .listen((value) {
      peopleReacted = [];
      for (var element in value.docs) {
        peopleReacted.add(LikesModel.fromJson(element.data()));
      }
      emit(GetLikedUsersSuccessState());
    });
  }

  File? commentImage;
  Future getCommentImage() async {
    emit(UpdatePostLoadingState());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      commentImage = File(pickedFile.path);
      emit(GetCommentImageSuccessState());
    } else {
      emit(GetCommentImageErrorState());
    }
  }

  void popCommentImage() {
    commentImage = null;
    emit(DeleteCommentImageState());
  }

  String? commentImageURL;
  bool isCommentImageLoading = false;
  void uploadCommentImage({
    required String postId,
    String? commentText,
    required DateTime time,
    double? commentImageWidth,
    double? commentImageHeight,
  }) {
    isCommentImageLoading = true;
    emit(UploadCommentImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('commentImage/${Uri.file(commentImage!.path).pathSegments.last}')
        .putFile(commentImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        commentImageURL = value;
        commentPost(
          postId: postId,
          comment: commentText,
          commentImage: {
            'width': commentImageWidth,
            'image': value,
            'height': commentImageHeight
          },
          time: time,
        );
        emit(UploadCommentImageSuccessState());
        isCommentImageLoading = false;
      }).catchError((error) {
        emit(UploadCommentImageErrorState());
      });
    }).catchError((error) {
      emit(UploadCommentImageErrorState());
    });
  }

  void commentPost({
    required String postId,
    String? comment,
    Map<String, dynamic>? commentImage,
    required DateTime time,
  }) {
    CommentModel commentModel = CommentModel(
      name: userModel!.name,
      userImage: userModel!.image,
      uId: userModel!.uId,
      commentText: comment,
      commentImage: commentImage,
      dateTime: time,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(commentModel.toMap())
        .then((value) {
      getPosts();
      emit(CommentPostSuccessState());
    }).catchError((error) {
      emit(CommentPostErrorState());
    });
  }

  List<CommentModel> comments = [];
  void getComments(postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      comments.clear();
      for (var element in event.docs) {
        comments.add(CommentModel.fromJson(element.data()));
        emit(GetCommentsSuccessState());
      }
    });
  }

  var random = Random();

  Future<void> saveImageToGallery(context, String imageUrl) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    late String message;
    emit(SavedToGalleryLoadingState());
    try {
      // Download image
      final http.Response response = await http.get(Uri.parse(imageUrl));

      // Get temporary directory
      final dir = await getTemporaryDirectory();

      // Create an image name
      var filename = '${dir.path}/SaveImage${random.nextInt(100)}.png';

      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      // Ask the user to save it
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        message = 'Image saved to disk';
      }
    } catch (e) {
      emit(SavedToGalleryErrorState());
      message = e.toString();
      scaffoldMessenger.showSnackBar(SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorManager.redColor,
      ));
    }
    emit(SavedToGallerySuccessState());
    scaffoldMessenger.showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: ColorManager.greenColor,
    ));
  }

  void editPost({
    required String dateTime,
    required PostModel postModel,
    required String postId,
    required String text,
    String? postImage,
  }) {
    emit(EditPostLoadingState());
    postModel = PostModel(
        name: userModel!.name,
        image: userModel!.image,
        uId: userModel!.uId,
        dateTime: postModel.dateTime,
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
        emit(EditPostErrorState());
      });
    }).catchError((error) {
      emit(EditPostErrorState());
    });
  }

  void deleteAccount(context) async {
    await FirebaseAuth.instance.currentUser!.delete().then((value) async {
      await FirebaseFirestore.instance.collection('users').doc(uId).delete();
      CacheHelper.removeData(key: 'uId');
      navigateAndFinish(context, const OnBoardingScreen());
    });
  }

  void deletePost(String? postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .delete()
        .then((value) {
      showToast(text: AppString.deletePost, state: ToastStates.success);
      emit(DeletePostSuccessState());
    });
  }

  void changeUserPassword({
    required String newPassword,
  }) {
    emit(ChangeUserPasswordLoadingState());
    FirebaseAuth.instance.currentUser
        ?.updatePassword(newPassword)
        .then((value) {
      showToast(
        state: ToastStates.success,
        text: AppString.changePasswordSuccessfully,
      );
      emit(ChangeUserPasswordSuccessState());
      getUserData();
    }).catchError((error) {
      showToast(
        state: ToastStates.error,
        text: AppString.changePasswordError,
      );
      emit(ChangeUserPasswordErrorState(error.toString()));
    });
  }

  IconData suffix = IconlyBroken.show;
  bool isPassword = true;
  void showPassword() {
    isPassword = !isPassword;
    suffix = isPassword ? IconlyBroken.show : IconlyBroken.hide;
    emit(ShowPasswordState());
  }

  IconData suffixIcon = IconlyBroken.show;
  bool iSPassword = true;
  void showConfirmPassword() {
    iSPassword = !iSPassword;
    suffixIcon = iSPassword ? IconlyBroken.show : IconlyBroken.hide;
    emit(ChangeConfirmPasswordState());
  }

  MessageModel? messageModel;
  void sendMessage({
    required String receiverId,
    required String messageId,
    required DateTime dateTime,
    String? text,
    String? messageImage,
  }) {
    MessageModel model = MessageModel(
      messageId: messageId,
      receiverId: receiverId,
      dateTime: dateTime,
      text: text ?? '',
      senderId: userModel!.uId,
      messageImage: messageImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chat')
        .doc(receiverId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(userModel!.uId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> message = [];
  void getMessage({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chat')
        .doc(receiverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      message = [];
      for (var element in event.docs) {
        message.add(MessageModel.fromJson(element.data()));
      }
      emit(GetMessageSuccessState());
    });
  }

  File? messageImagePicked;
  Future<void> getMessageImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      messageImagePicked = File(pickedFile.path);
      emit(MessageImagePickedSuccessState());
    } else {
      emit(MessageImagePickedErrorState());
    }
  }

  void removeMessageImage() {
    messageImagePicked = null;
    emit(DeleteMessageImageSuccessState());
  }

  void uploadMessageImage({
    required String receiverId,
    required String messageId,
    required DateTime datetime,
    String? text,
  }) {
    emit(UploadMessageImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'messagesImage/${Uri.file(messageImagePicked!.path).pathSegments.last}')
        .putFile(messageImagePicked!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMessage(
          dateTime: datetime,
          text: text,
          messageImage: value,
          receiverId: receiverId,
          messageId: messageId,
        );
      }).catchError((error) {
        emit(UploadMessageImageErrorState());
      });
    }).catchError((error) {
      emit(UploadMessageImageErrorState());
    });
  }

  UserModel? friendsProfile;
  getFriendsProfile(String? friendsUID) {
    emit(GetFriendProfileLoadingState());
    FirebaseFirestore.instance.collection('users').snapshots().listen((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] == friendsUID) {
          friendsProfile = UserModel.fromJson(element.data());
        }
      }

      emit(GetFriendProfileSuccessState());
    });
  }

  void addFriend({
    required String friendsUID,
    required String friendName,
    required String friendImage,
    required String friendPhone,
    required String friendEmail,
    required String friendCover,
    required String friendBio,
  }) {
    emit(AddFriendLoadingState());
    UserModel myFriendModel = UserModel(
      uId: friendsUID,
      name: friendName,
      image: friendImage,
      phone: friendPhone,
      email: friendEmail,
      cover: friendCover,
      bio: friendBio,
      isEmailVerified: userModel!.isEmailVerified,
    );
    UserModel myModel = UserModel(
      uId: userModel!.uId,
      name: userModel!.name,
      image: userModel!.image,
      cover: userModel!.cover,
      bio: userModel!.bio,
      phone: userModel!.phone,
      email: userModel!.email,
      isEmailVerified: userModel!.isEmailVerified,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('friends')
        .doc(friendsUID)
        .set(myFriendModel.toMap())
        .then((value) {
      emit(AddFriendSuccessState());
    }).catchError((error) {
      emit(AddFriendErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(friendsUID)
        .collection('friends')
        .doc(userModel!.uId)
        .set(myModel.toMap())
        .then((value) {
      emit(AddFriendSuccessState());
    }).catchError((error) {
      emit(AddFriendErrorState());
    });
  }

  List<UserModel> friends = [];
  void getFriends(String? userUID) {
    emit(GetFriendLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userUID)
        .collection('friends')
        .snapshots()
        .listen((value) {
      friends = [];
      for (var element in value.docs) {
        friends.add(UserModel.fromJson(element.data()));
      }
      emit(GetFriendSuccessState());
    });
  }

  bool isFriend = false;
  bool checkFriends(String? friendUID) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('friends')
        .snapshots()
        .listen((value) {
      for (var element in value.docs) {
        if (friendUID != element.id) isFriend = true;
      }
      emit(CheckFriendSuccessState());
    });
    return isFriend;
  }

  void unFriend(String? friendsUID) {
    emit(UnFriendLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('friends')
        .doc(friendsUID)
        .delete()
        .then((value) {
      emit(UnFriendSuccessState());
    }).catchError((error) {
      emit(UnFriendErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(friendsUID)
        .collection('friends')
        .doc(userModel!.uId)
        .delete()
        .then((value) {
      emit(UnFriendSuccessState());
    }).catchError((error) {
      emit(UnFriendErrorState());
    });
  }

  void sendFriendRequest({
    required String friendsUID,
    required String friendName,
    required String friendImage,
  }) {
    emit(FriendRequestLoadingState());
    UserModel friendRequestModel = UserModel(
      uId: userModel!.uId,
      name: userModel!.name,
      image: userModel!.image,
      bio: userModel!.bio,
      phone: userModel!.phone,
      email: userModel!.email,
      cover: userModel!.cover,
      isEmailVerified: userModel!.isEmailVerified,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(friendsUID)
        .collection('friendRequests')
        .doc(userModel!.uId)
        .set(friendRequestModel.toMap())
        .then((value) {
      emit(FriendRequestSuccessState());
    }).catchError((error) {
      emit(FriendRequestErrorState());
    });
  }

  List<UserModel> friendRequests = [];
  void getFriendRequest() {
    emit(GetFriendLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('friendRequests')
        .snapshots()
        .listen((value) {
      friendRequests = [];
      for (var element in value.docs) {
        friendRequests.add(UserModel.fromJson(element.data()));
        emit(GetFriendSuccessState());
      }
    });
  }

  bool request = false;
  bool checkFriendRequest(String? friendUID) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(friendUID)
        .collection('friendRequests')
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] == userModel!.uId) {
          request = true;
        } else {
          request = false;
        }
      }
      emit(CheckFriendRequestSuccessState());
    });
    return request;
  }

  void deleteFriendRequest(String? friendsUID) {
    emit(DeleteFriendRequestLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('friendRequests')
        .doc(friendsUID)
        .delete()
        .then((value) {
      emit(DeleteFriendRequestSuccessState());
    }).catchError((error) {
      emit(DeleteFriendRequestErrorState());
      debugPrint(error.toString());
    });
  }

  PostModel? singlePost;
  void getSinglePost(String? postId) {
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .get()
        .then((value) {
      singlePost = PostModel.fromJson(value.data()!);
      emit(GetSinglePostSuccessState());
    }).catchError((error) {
      emit(GetPostsErrorState(error.toString()));
    });
  }

  void deleteForEveryone(
      {required String? messageId, required String? receiverId}) async {
    var myDocument = await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chat')
        .doc(receiverId!)
        .collection('message')
        .limit(1)
        .where('messageId', isEqualTo: messageId)
        .get();
    myDocument.docs[0].reference.delete();
    var hisDocument = await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(userModel!.uId)
        .collection('message')
        .limit(1)
        .where('messageId', isEqualTo: messageId)
        .get();
    hisDocument.docs[0].reference.delete();
  }

  void deleteForMe(
      {required String? messageId, required String? receiverId}) async {
    var myDocument = await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chat')
        .doc(receiverId)
        .collection('message')
        .limit(1)
        .where('messageId', isEqualTo: messageId)
        .get();
    myDocument.docs[0].reference.delete();
  }

  List<StoryModel> stories = [];
  void getStories() {
    emit(GetStoryLoadingState());
    FirebaseFirestore.instance
        .collection('stories')
        .snapshots()
        .listen((event) {
      stories = [];
      for (var element in event.docs) {
        stories.add(StoryModel.fromJson(element.data()));
      }
    });
    emit(GetStorySuccessState());
  }

  File? storyImage;
  Future<void> getStoryImage(context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      storyImage = File(pickedFile.path);
      storyImage = await cropImage(imageFile: storyImage!);

      emit(CreateStoryImagePickedSuccessState());
    } else {
      emit(CreateStoryImagePickedErrorState());
    }
  }

  void createStoryImage({
    required DateTime dateTime,
    String? text,
  }) {
    emit(CreateStoryLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('stories/${Uri.file(storyImage!.path).pathSegments.last}')
        .putFile(storyImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        uploadStory(dateTime: dateTime, text: text, storyImage: value);
        emit(CreateStorySuccessState());
        debugPrint(value);
      }).catchError((error) {
        emit(CreateStoryErrorState());
      });
    }).catchError((error) {
      emit(CreateStoryErrorState());
    });
  }

  void uploadStory({
    required DateTime dateTime,
    String? text,
    required String storyImage,
  }) {
    StoryModel storyModel = StoryModel(
      uId: userModel!.uId,
      dateTime: dateTime,
      name: userModel!.name,
      text: text ?? "",
      storyImage: storyImage,
      image: userModel!.image,
    );
    FirebaseFirestore.instance
        .collection('stories')
        .add(storyModel.toMap())
        .then((value) {
      emit(CreateStorySuccessState());
    }).catchError((error) {
      emit(CreateStoryErrorState());
    });
  }

  void removeStoryImage() {
    storyImage = null;
    emit(RemoveStoryImagePickedSuccessState());
  }

  bool addText = false;
  void addTextStory() {
    addText = !addText;
    emit(AddTextSuccessState());
  }

  void closeStory(context) {
    pop(context);
    emit(CloseCreateStoryScreenState());
  }

  List<StoryModel> userStories = [];
  void getUserStories(String? storyUID) {
    emit(CreateStoryLoadingState());
    userStories = [];
    for (var element in stories) {
      if (element.uId == userModel!.uId) userStories.add(element);
    }
    emit(GetStorySuccessState());
  }

  List<UserModel> searchList = [];
  Map<String, dynamic>? search;
  void searchUser(String? searchText) {
    emit(SearchLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: searchText)
        .get()
        .then((value) {
      search = value.docs[0].data();
      emit(SearchSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SearchErrorState(error.toString()));
    });
  }

  String? imageURL;
  Future<void> sendFCMNotification({
    required String token,
    required String senderName,
    String? messageText,
    String? messageImage,
  }) async {
    DioHelper.postData(data: {
      "to": token,
      "notification": {
        "title": senderName,
        "body": messageText ?? (messageImage != null ? 'Photo' : 'ERROR 404'),
        "sound": "default"
      },
      "android": {
        "Priority": "HIGH",
      },
      "data": {
        "type": "order",
        "id": "87",
        "click_action": "FLUTTER_NOTIFICATION_CLICK"
      }
    });
    emit(SendFCMNotificationSuccessState());
  }

  void sendInAppNotification({
    String? contentKey,
    String? contentId,
    String? content,
    String? receiverName,
    String? receiverId,
  }) {
    emit(SendInAppNotificationLoadingState());
    NotificationModel notificationModel = NotificationModel(
      contentKey: contentKey,
      contentId: contentId,
      content: content,
      senderName: userModel!.name,
      receiverName: receiverName,
      senderId: userModel!.uId,
      receiverId: receiverId,
      senderImage: userModel!.image,
      read: false,
      dateTime: DateTime.now(),
      serverTimeStamp: FieldValue.serverTimestamp(),
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('notifications')
        .add(notificationModel.toMap())
        .then((value) async {
      await setNotificationId();
      emit(SendInAppNotificationLoadingState());
    }).catchError((error) {
      emit(SendInAppNotificationLoadingState());
    });
  }

  List<NotificationModel> notifications = [];
  void getInAppNotification() async {
    emit(GetInAppNotificationLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('notifications')
        .snapshots()
        .listen((event) async {
      notifications = [];
      for (var element in event.docs) {
        notifications.add(NotificationModel.fromJson(element.data()));
      }
      emit(GetInAppNotificationSuccessState());
    });
  }

  int unReadNotificationsCount = 0;
  Future<int> getUnReadNotificationsCount() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('notifications')
        .snapshots()
        .listen((event) {
      unReadNotificationsCount = 0;
      for (int i = 0; i < event.docs.length; i++) {
        if (event.docs[i]['read'] == false) {
          unReadNotificationsCount++;
        }
      }
      emit(ReadNotificationSuccessState());
    });
    return unReadNotificationsCount;
  }

  Future setNotificationId() async {
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) async {
        var notifications =
            await element.reference.collection('notifications').get();
        notifications.docs.forEach((notificationsElement) async {
          await notificationsElement.reference
              .update({'notificationId': notificationsElement.id});
        });
      });
      emit(SetNotificationIdSuccessState());
    });
  }

  Future readNotification(String? notificationId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('notifications')
        .doc(notificationId)
        .update({'read': true}).then((value) {
      emit(ReadNotificationSuccessState());
    });
  }

  void deleteNotification(String? notificationId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('notifications')
        .doc(notificationId)
        .delete()
        .then((value) {
      emit(ReadNotificationSuccessState());
    });
  }

  String notificationContent(String? contentKey) {
    if (contentKey == AppString.post) {
      return AppString.post;
    }
    if (contentKey == AppString.likePost) {
      return AppString.likePost;
    } else if (contentKey == AppString.commentPost) {
      return AppString.commentPost;
    } else if (contentKey == AppString.requestAccepted) {
      return AppString.requestAccepted;
    } else {
      return AppString.friendRequest;
    }
  }

  IconData notificationContentIcon(String? contentKey) {
    if (contentKey == AppString.likePost) {
      return IconlyBroken.heart;
    } else if (contentKey == AppString.commentPost) {
      return IconlyBroken.chat;
    } else if (contentKey == AppString.requestAccepted) {
      return IconlyBroken.user2;
    } else {
      return IconlyBroken.user2;
    }
  }

  bool showTime = false;
  void showTimes() {
    showTime = !showTime;
    emit(ShowTimeState());
  }
}
