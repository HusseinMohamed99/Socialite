import 'package:sociality/Pages/comment/comment_screen.dart';
import 'package:sociality/Pages/friend/profile_screen.dart';
import 'package:sociality/Pages/post/edit_post.dart';
import 'package:sociality/Pages/profile/my_profile_screen.dart';
import 'package:sociality/Pages/viewPhoto/post_view.dart';
import 'package:sociality/model/post_model.dart';
import 'package:sociality/model/user_model.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

void showToast({
  required String text,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 10,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastStates { success, error, waring }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;

    case ToastStates.error:
      color = Colors.red;
      break;

    case ToastStates.waring:
      color = Colors.amber;
      break;
  }
  return color;
}

// Widget imagePreview(){
//   return FullScreenWidget(
//     child: Center(
//       child: Image.network(
//         "$image",
//         fit: BoxFit.cover,
//         width: double.infinity,
//         alignment: AlignmentDirectional.topCenter,
//       ),
//     ),
//   );
// }

Widget baseAlertDialog({
  required context,
  String? title,
  String? content,
  String? outlinedButtonText,
  String? elevatedButtonText,
  IconData? elevatedButtonIcon,
}) {
  return AlertDialog(
    backgroundColor: SocialCubit.get(context).backgroundColor.withOpacity(1),
    title: Text(
      '$title',
      style: const TextStyle(color: Colors.red),
    ),
    titlePadding: const EdgeInsetsDirectional.only(start: 13, top: 15),
    content: Text(
      '$content',
      style: const TextStyle(
        color: Colors.grey,
      ),
    ),
    elevation: 8,
    contentPadding: const EdgeInsets.all(15),
    actions: [
      OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text('$outlinedButtonText')),
      SizedBox(
        width: 115,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blueAccent)),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(elevatedButtonIcon),
              const SizedBox(
                width: 5,
              ),
              Text('$elevatedButtonText',
                  style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget searchBar({
  required context,
  bool readOnly = true,
  double height = 40,
  double width = double.infinity,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    height: height,
    width: width,
    child: TextFormField(
      readOnly: readOnly,
      style: const TextStyle(color: Colors.grey),
      // onTap: () => navigateTo(context, SearchScreen()),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: true,
        // fillColor: SocialCubit.get(context).unreadMessage,
        disabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        hintText: 'LocaleKeys.search.tr()',
        hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
      ),
    ),
  );
}

Widget buildPost(index, context, state, PostModel postModel, UserModel? model,
    GlobalKey<ScaffoldState> scaffoldKey,
    {required bool isSingle}) {
  late String postId;
  var cubit = SocialCubit.get(context);
  postId = SocialCubit.get(context).postsId[index];
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 10,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    child: Padding(
      padding: const EdgeInsets.all(10.0).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (postModel.uId !=
                      SocialCubit.get(context).userModel!.uId) {
                    navigateTo(context, FriendsProfileScreen(postModel.uId));
                  } else {
                    navigateTo(context, const MyProfileScreen());
                  }
                },
                borderRadius: BorderRadius.circular(25),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    '${postModel.image}',
                  ),
                ),
              ),
              space(15, 0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (postModel.uId !=
                                SocialCubit.get(context).userModel!.uId) {
                              navigateTo(
                                  context, FriendsProfileScreen(postModel.uId));
                            } else {
                              navigateTo(context, const MyProfileScreen());
                            }
                          },
                          child: Text(
                            '${postModel.name}',
                            style: GoogleFonts.lobster(
                              fontSize: 20,
                              height: 1.3,
                              color: SocialCubit.get(context).isDark
                                  ? CupertinoColors.activeBlue
                                  : Colors.white,
                            ),
                          ),
                        ),
                        space(10, 0),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ],
                    ),
                    Text(
                      daysBetween(
                          DateTime.parse(postModel.dateTime.toString())),
                      style: GoogleFonts.lobster(
                          fontSize: 15,
                          color: Colors.grey,
                          textStyle: Theme.of(context).textTheme.bodySmall,
                          height: 1.3),
                    ),
                  ],
                ),
              ),
              space(15, 0),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30))),
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (postModel.uId == cubit.userModel!.uId)
                                InkWell(
                                  onTap: () {
                                    navigateTo(
                                        context,
                                        EditPosts(
                                          postModel: postModel,
                                          postId: postId,
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      right: 8,
                                      top: 20,
                                      bottom: 0,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.edit_location_outlined,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                        space(10, 0),
                                        const Text(
                                          "Edit Post",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              InkWell(
                                onTap: () {
                                  // cubit.savePost(
                                  //     postId: postId,
                                  //     date: DateTime.now(),
                                  //     userName: model.name,
                                  //     userId: model.uId,
                                  //     userImage: model.image,
                                  //     postText: model.text,
                                  //     postImage: model.postImage);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                    top: 20,
                                    bottom: 0,
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.turned_in_not_sharp,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                      space(10, 0),
                                      const Text(
                                        "Save Post",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              if (postModel.postImage != '')
                                InkWell(
                                  onTap: () {
                                    cubit.saveToGallery(postModel.postImage!);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      right: 8,
                                      top: 20,
                                      bottom: 0,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          IconlyLight.download,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                        space(10, 0),
                                        const Text(
                                          "Save Image",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                    top: 20,
                                    bottom: 0,
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.share,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                      space(10, 0),
                                      const Text(
                                        "Share",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              if (postModel.uId == cubit.userModel!.uId)
                                InkWell(
                                  onTap: () {
                                    cubit.deletePost(postId);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      right: 8,
                                      top: 20,
                                      bottom: 0,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                        space(10, 0),
                                        const Text(
                                          "Delete Post",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      });
                },
                icon: Icon(
                  IconlyLight.moreCircle,
                  size: 25,
                  color: SocialCubit.get(context).isDark
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              color: Colors.grey[300],
              height: 2,
              width: double.infinity,
            ),
          ),
          Text(
            '${postModel.text}',
            style: GoogleFonts.libreBaskerville(
              color:
                  SocialCubit.get(context).isDark ? Colors.black : Colors.white,
            ),
          ),
          space(0, 12),
          if (postModel.postImage != '')
            InkWell(
              onTap: () {
                navigateTo(
                    context,
                    FullScreen(
                      postModel,
                      index: index,
                    ));
              },
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Container(
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            // blurRadius: 0,
                            // spreadRadius: 0,
                            // offset: Offset(0, 0)
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image(
                          image: NetworkImage('${postModel.postImage}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  IconlyLight.heart,
                  color: Colors.red,
                ),
                label: Text(
                  '${postModel.likes}',
                  style: GoogleFonts.lobster(
                    color: Colors.red,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  navigateTo(
                      context,
                      CommentsScreen(
                        SocialCubit.get(context).postsId[index],
                        postModel.uId,
                      ));
                },
                icon: const Icon(
                  IconlyLight.chat,
                  color: Colors.orangeAccent,
                ),
                label: Text(
                  '${SocialCubit.get(context).commentsNum[index]}',
                  style: GoogleFonts.lobster(
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Container(
              color: Colors.grey[300],
              height: 2,
              width: double.infinity,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  navigateTo(context, const MyProfileScreen());
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage('${postModel.image}'),
                ),
              ),
              space(10, 0),
              InkWell(
                onTap: () {
                  navigateTo(
                      context,
                      CommentsScreen(
                        SocialCubit.get(context).postsId[index],
                        postModel.uId,
                      ));
                },
                child: SizedBox(
                  width: 150,
                  child: Text(
                    'Write a comment ...',
                    style: GoogleFonts.lobster(
                      textStyle: Theme.of(context).textTheme.bodySmall,
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () async {
                  UserModel? postUser = SocialCubit.get(context).userModel;

                  await cubit.likeByMe(
                      postUser: postUser,
                      context: context,
                      postModel: postModel,
                      postId: postModel.uId);
                },
                label: Text(
                  'Like',
                  style: GoogleFonts.lobster(
                    color: Colors.grey,
                  ),
                ),
                icon: const Icon(
                  IconlyLight.heart,
                  color: Colors.grey,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  IconlyLight.upload,
                  color: Colors.green,
                ),
                label: Text(
                  'Share',
                  style: GoogleFonts.lobster(
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

PreferredSizeWidget defaultAppBar() => AppBar(
      backgroundColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light),
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 0,
    );

PreferredSizeWidget secondAppBar() => AppBar(
      backgroundColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 0,
    );
