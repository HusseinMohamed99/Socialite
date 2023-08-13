import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:sociality/Pages/addPost/add_post_screen.dart';
import 'package:sociality/Pages/comment/comment_screen.dart';
import 'package:sociality/Pages/friend/profile_screen.dart';
import 'package:sociality/Pages/post/edit_post.dart';
import 'package:sociality/Pages/profile/my_profile_screen.dart';
import 'package:sociality/Pages/story/veiw_story.dart';
import 'package:sociality/adaptive/indicator.dart';
import 'package:sociality/model/post_model.dart';
import 'package:sociality/model/story_model.dart';
import 'package:sociality/pages/viewPhoto/post_view.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/cubit/socialCubit/social_state.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SavedToGalleryLoadingState) {
          Navigator.pop(context);
        }
        if (state is SavedToGallerySuccessState) {
          Fluttertoast.showToast(
            msg: "Downloaded to Gallery!",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            timeInSecForIosWeb: 5,
            fontSize: 18.sp,
          );
        }
        if (state is LikesSuccessState) {
          Fluttertoast.showToast(
            msg: "Likes Success!",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            timeInSecForIosWeb: 5,
            fontSize: 18.sp,
          );
        }
        if (state is DisLikesSuccessState) {
          Fluttertoast.showToast(
            msg: "UnLikes Success!",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            timeInSecForIosWeb: 5,
            fontSize: 18.sp,
          );
        }
      },
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var cubit = SocialCubit.get(context);
        return SocialCubit.get(context).posts.isEmpty
            ? Scaffold(
                body: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10,
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(cubit.userModel!.image),
                            ),
                            Expanded(
                              child: Container(
                                width: 220.w,
                                height: 50.h,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                margin: const EdgeInsets.all(10).r,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                  ),
                                  borderRadius: BorderRadius.circular(25).r,
                                ),
                                child: TextButton(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(
                                      Colors.grey[300],
                                    ),
                                  ),
                                  child: Text(
                                    '\' What\'s on your mind ? \'',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16.sp,
                                      color: SocialCubit.get(context).isDark
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    navigateTo(
                                      context,
                                      AddPostScreen(),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: 2.w,
                              height: 50.h,
                              color: Colors.grey,
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.getPostImage();
                                navigateTo(context, AddPostScreen());
                              },
                              icon: Icon(
                                Icons.photo_library_outlined,
                                size: 30.sp,
                                color: cubit.isDark
                                    ? CupertinoColors.activeBlue
                                    : Colors.white,
                              ),
                              splashRadius: 20.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Icon(
                          IconlyLight.infoSquare,
                          size: 100.sp,
                          color: Colors.grey,
                        ),
                        Text(
                          'No Posts yet',
                          style: GoogleFonts.libreBaskerville(
                            fontWeight: FontWeight.w700,
                            fontSize: 30.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              )
            : ConditionalBuilder(
                condition: cubit.posts.isNotEmpty,
                builder: (BuildContext context) => RefreshIndicator(
                  onRefresh: () async {
                    cubit.getPosts();
                    return cubit.getUserData();
                  },
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0).r,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    cubit.getStoryImage(context);
                                  },
                                  child: Container(
                                    width: 110.w,
                                    height: 140.h,
                                    margin:
                                        EdgeInsetsDirectional.only(start: 8.r),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(17).r),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 125.h,
                                          child: Stack(
                                            alignment: AlignmentDirectional
                                                .bottomCenter,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional
                                                    .topCenter,
                                                child: Container(
                                                  width: 110.w,
                                                  height: 100.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(17),
                                                      topLeft:
                                                          Radius.circular(17),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    ).r,
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        cubit.userModel!.image,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              CircleAvatar(
                                                radius: 20.r,
                                                backgroundColor: Colors.grey
                                                    .withOpacity(0.3),
                                                child: CircleAvatar(
                                                  radius: 18.r,
                                                  backgroundColor: Colors.blue,
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 24.sp,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "Create Story",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                ),
                                space(10.w, 0),
                                SizedBox(
                                  height: 140.h,
                                  child: ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      reverse: true,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          storyItem(
                                              context, cubit.stories[index]),
                                      separatorBuilder: (context, index) =>
                                          space(10.w, 0),
                                      itemCount: cubit.stories.length),
                                ),
                                space(10.w, 0),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 10,
                          margin: const EdgeInsets.all(10).r,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0.r),
                            child: Row(
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(20).r,
                                  onTap: () {
                                    navigateTo(
                                      context,
                                      const MyProfileScreen(),
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: 20.r,
                                    backgroundImage:
                                        NetworkImage(userModel!.image),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: 220.w,
                                    height: 35.h,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    margin: const EdgeInsets.all(10).r,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(25).r,
                                    ),
                                    child: TextButton(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.all(
                                          Colors.grey[300],
                                        ),
                                      ),
                                      child: Text(
                                        '\' What\'s on your mind ? \'',
                                        style: GoogleFonts.roboto(
                                          fontSize: 16.sp,
                                          color: SocialCubit.get(context).isDark
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                      onPressed: () {
                                        navigateTo(
                                          context,
                                          AddPostScreen(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 2.w,
                                  height: 50.h,
                                  color: Colors.grey,
                                ),
                                IconButton(
                                  onPressed: () {
                                    cubit.getPostImage();
                                    navigateTo(
                                      context,
                                      AddPostScreen(),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.photo_library_outlined,
                                    size: 30.sp,
                                    color: cubit.isDark
                                        ? CupertinoColors.activeBlue
                                        : Colors.white,
                                  ),
                                  splashRadius: 20.r,
                                ),
                              ],
                            ),
                          ),
                        ),
                        space(0, 10.h),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cubit.posts.length,
                          separatorBuilder: (context, index) => space(0, 10.h),
                          itemBuilder: (context, index) => (buildPostItem(
                              cubit.posts[index], context, index)),
                        ),
                      ],
                    ),
                  ),
                ),
                fallback: (BuildContext context) => Center(
                  child: AdaptiveIndicator(
                    os: getOs(),
                  ),
                ),
              );
      },
    );
  }

  Widget buildPostItem(PostModel postModel, context, index) {
    late String postId;
    var cubit = SocialCubit.get(context);
    postId = SocialCubit.get(context).postsId[index];
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 8).r,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
                        context,
                        FriendsProfileScreen(postModel.uId),
                      );
                      SocialCubit.get(context).getFriendsProfile(postModel.uId);
                    } else {
                      navigateTo(
                        context,
                        const MyProfileScreen(),
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(25).r,
                  child: CircleAvatar(
                    radius: 25.r,
                    backgroundImage: NetworkImage(
                      '${postModel.image}',
                    ),
                  ),
                ),
                space(15.w, 0),
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
                                navigateTo(context,
                                    FriendsProfileScreen(postModel.uId));
                              } else {
                                navigateTo(
                                  context,
                                  const MyProfileScreen(),
                                );
                              }
                            },
                            child: Text(
                              '${postModel.name}',
                              style: GoogleFonts.roboto(
                                fontSize: 20.sp,
                                height: 1.3.h,
                                color: SocialCubit.get(context).isDark
                                    ? CupertinoColors.activeBlue
                                    : Colors.white,
                              ),
                            ),
                          ),
                          space(5.w, 0),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 20.sp,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            LineariconsFree.earth,
                            size: 20.sp,
                            color: Colors.grey,
                          ),
                          space(10.w, 0),
                          Text(
                            daysBetween(
                                DateTime.parse(postModel.dateTime.toString())),
                            style: GoogleFonts.roboto(
                              fontSize: 15.sp,
                              color: Colors.grey,
                              textStyle: Theme.of(context).textTheme.bodySmall,
                              height: 1.3.h,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                space(15.w, 0),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(30),
                          ).r,
                        ),
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(15.0).r,
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
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 8.r,
                                        right: 8.r,
                                        top: 20.r,
                                        bottom: 0.r,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.edit_location_outlined,
                                            color: cubit.isDark
                                                ? Colors.black
                                                : Colors.white,
                                            size: 30.sp,
                                          ),
                                          space(10.w, 0),
                                          Text(
                                            "Edit Post",
                                            style: TextStyle(
                                                color: cubit.isDark
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20.sp),
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
                                    padding: EdgeInsets.only(
                                      left: 8.r,
                                      right: 8.r,
                                      top: 20.r,
                                      bottom: 0.r,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.turned_in_not_sharp,
                                          color: cubit.isDark
                                              ? Colors.black
                                              : Colors.white,
                                          size: 30.sp,
                                        ),
                                        space(10.w, 0),
                                        Text(
                                          "Save Post",
                                          style: TextStyle(
                                            color: cubit.isDark
                                                ? Colors.black
                                                : Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20.sp,
                                          ),
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
                                      padding: EdgeInsets.only(
                                        left: 8.r,
                                        right: 8.r,
                                        top: 20.r,
                                        bottom: 0.r,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            IconlyLight.download,
                                            color: cubit.isDark
                                                ? Colors.black
                                                : Colors.white,
                                            size: 30.sp,
                                          ),
                                          space(10.w, 0),
                                          Text(
                                            "Save Image",
                                            style: TextStyle(
                                              color: cubit.isDark
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20.sp,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 8.r,
                                      right: 8.r,
                                      top: 20.r,
                                      bottom: 0.r,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.share,
                                          color: cubit.isDark
                                              ? Colors.black
                                              : Colors.white,
                                          size: 30.sp,
                                        ),
                                        space(10.w, 0),
                                        Text(
                                          "Share",
                                          style: TextStyle(
                                            color: cubit.isDark
                                                ? Colors.black
                                                : Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20.sp,
                                          ),
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
                                      padding: EdgeInsets.only(
                                        left: 8.r,
                                        right: 8.r,
                                        top: 20.r,
                                        bottom: 0.r,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.delete,
                                            color: cubit.isDark
                                                ? Colors.black
                                                : Colors.white,
                                            size: 30.sp,
                                          ),
                                          space(10.w, 0),
                                          Text(
                                            "Delete Post",
                                            style: TextStyle(
                                              color: cubit.isDark
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20.sp,
                                            ),
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
                    size: 25.sp,
                    color: SocialCubit.get(context).isDark
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0).r,
              child: Container(
                color: Colors.grey[300],
                height: 2.h,
                width: double.infinity,
              ),
            ),
            Text(
              '${postModel.text}',
              style: GoogleFonts.libreBaskerville(
                color: SocialCubit.get(context).isDark
                    ? Colors.black
                    : Colors.white,
              ),
            ),
            space(0, 12.h),
            if (postModel.postImage != '')
              InkWell(
                onTap: () {
                  navigateTo(
                    context,
                    FullScreen(
                      postModel,
                      index: index,
                    ),
                  );
                },
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Container(
                        height: 320,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4).r,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15).r,
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
                  onPressed: () {
                    // navigateTo(context, LikesScreen(SocialCubit.get(context).postsId[index],postModel.uId));
                  },
                  icon: Icon(
                    IconlyLight.heart,
                    color: Colors.red,
                    size: 24.sp,
                  ),
                  label: Text(
                    SocialCubit.get(context).likes.isEmpty
                        ? ''
                        : '${SocialCubit.get(context).likes[index]}',
                    style: GoogleFonts.roboto(
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
                      ),
                    );
                  },
                  icon: Icon(
                    IconlyLight.chat,
                    color: Colors.orangeAccent,
                    size: 24.sp,
                  ),
                  label: Text(
                    '${SocialCubit.get(context).commentsNum[index]}',
                    style: GoogleFonts.roboto(
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.grey[300],
              height: 1.h,
              width: double.infinity,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    navigateTo(context, const MyProfileScreen());
                  },
                  child: CircleAvatar(
                    radius: 17.r,
                    backgroundImage:
                        NetworkImage(SocialCubit.get(context).userModel!.image),
                  ),
                ),
                space(8.w, 0),
                InkWell(
                  onTap: () {
                    navigateTo(
                      context,
                      CommentsScreen(
                        SocialCubit.get(context).postsId[index],
                        postModel.uId,
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 120.w,
                    child: Text(
                      'Write a comment ...',
                      style: GoogleFonts.roboto(
                        textStyle: Theme.of(context).textTheme.bodySmall,
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    if (SocialCubit.get(context).likedByMe[index] == true) {
                      SocialCubit.get(context)
                          .disLikePost(SocialCubit.get(context).postsId[index]);
                      SocialCubit.get(context).likedByMe[index] = false;
                      SocialCubit.get(context).likes[index]--;
                    } else {
                      SocialCubit.get(context)
                          .likePost(SocialCubit.get(context).postsId[index]);
                      SocialCubit.get(context).likedByMe[index] = true;
                      SocialCubit.get(context).likes[index]++;
                    }
                  },
                  label: Text(
                    'Like',
                    style: GoogleFonts.roboto(
                      color: SocialCubit.get(context).likedByMe[index] == true
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                  icon: Icon(
                    IconlyLight.heart,
                    color: SocialCubit.get(context).likedByMe[index] == true
                        ? Colors.red
                        : Colors.grey,
                    size: 24.sp,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    IconlyLight.upload,
                    color: Colors.green,
                    size: 24.sp,
                  ),
                  label: Text(
                    'Share',
                    style: GoogleFonts.roboto(
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

  Widget storyItem(context, StoryModel model) {
    var bloc = SocialCubit.get(context).userModel;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewStory(model),
          ),
        );
      },
      child: Container(
        width: 110.w,
        height: 180.h,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(17).r,
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14).r,
                  image: DecorationImage(
                    image: NetworkImage(model.storyImage!),
                    fit: BoxFit.cover,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 23.r,
                    child: CircleAvatar(
                      radius: 20.r,
                      backgroundImage: model.uId == bloc!.uId
                          ? NetworkImage(bloc.image)
                          : NetworkImage(model.image!),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 110.w,
                    height: 25.h,
                    child: Text(
                      model.uId == bloc.uId ? bloc.name : model.name!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
