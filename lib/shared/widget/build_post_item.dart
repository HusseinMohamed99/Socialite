import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sociality/model/post_model.dart';
import 'package:sociality/model/user_model.dart';
import 'package:sociality/pages/comment/comment_screen.dart';
import 'package:sociality/pages/friend/profile_screen.dart';
import 'package:sociality/pages/post/edit_post.dart';
import 'package:sociality/pages/post_like/likes_screen.dart';
import 'package:sociality/pages/profile/my_profile_screen.dart';
import 'package:sociality/pages/viewPhoto/post_view.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:sociality/shared/components/image_with_shimmer.dart';
import 'package:sociality/shared/components/my_divider.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/styles/color.dart';

class BuildPostItem extends StatelessWidget {
  const BuildPostItem(
      {super.key, required this.postModel, required this.index});

  final PostModel postModel;
  final int index;
  @override
  Widget build(BuildContext context) {
    var cubit = SocialCubit.get(context);
    late String postId;
    postId = SocialCubit.get(context).postsId[index];
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 8).r,
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
                    child: ImageWithShimmer(
                      radius: 75.r,
                      imageUrl: '${postModel.image}',
                      width: 100.w,
                      height: 100.h,
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
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 16.sp,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            LineariconsFree.earth,
                            size: 16.sp,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            daysBetween(
                                DateTime.parse(postModel.dateTime.toString())),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: AppMainColors.greyColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15.w),
                IconButton(
                  onPressed: () {
                    moreOption(context, cubit, postId);
                  },
                  icon: Icon(
                    IconlyLight.moreCircle,
                    size: 24.sp,
                    color: AppMainColors.greyColor,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0).r,
              child: MyDivider(color: AppMainColors.greyColor.withOpacity(0.5)),
            ),
            Text(
              '${postModel.text}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 12.w),
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
                      child: SizedBox(
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15).r,
                          child: ImageWithShimmer(
                            imageUrl: '${postModel.postImage}',
                            width: 110.w,
                            height: 110.h,
                            boxFit: BoxFit.fill,
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
                    navigateTo(
                      context,
                      LikesScreen(
                        SocialCubit.get(context).postsId[index],
                        postModel.uId,
                      ),
                    );
                  },
                  icon: Icon(
                    IconlyLight.heart,
                    color: Colors.red,
                    size: 24.sp,
                  ),
                  label: Text(
                    '${postModel.likes}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppMainColors.redColor),
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
                    '',
                    // '${SocialCubit.get(context).commentsNum[index]}' ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppMainColors.orangeColor),
                  ),
                ),
              ],
            ),
            MyDivider(
              color: AppMainColors.greyColor.withOpacity(0.4),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    navigateTo(context, const MyProfileScreen());
                  },
                  child: CircleAvatar(
                    radius: 15.r,
                    child: ImageWithShimmer(
                      imageUrl: SocialCubit.get(context).userModel!.image,
                      width: 40.w,
                      height: 40.h,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
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
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: AppMainColors.greyColor),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () async {
                    UserModel? postUser = SocialCubit.get(context).userModel;

                    await SocialCubit.get(context).likeByMe(
                        postUser: postUser,
                        context: context,
                        postModel: postModel,
                        postId: postModel.uId);
                  },
                  label: Text(
                    'Like',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: cubit.isLikedByMe
                            ? AppMainColors.greyColor
                            : AppMainColors.redColor),
                  ),
                  icon: Icon(
                    IconlyLight.heart,
                    color: cubit.isLikedByMe
                        ? AppMainColors.greyColor
                        : AppMainColors.redColor,
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

  Future<dynamic> moreOption(
      BuildContext context, SocialCubit cubit, String postId) {
    return showModalBottomSheet(
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
                            color: cubit.isDark ? Colors.black : Colors.white,
                            size: 30.sp,
                          ),
                          space(10.w, 0),
                          Text(
                            "Edit Post",
                            style: TextStyle(
                                color:
                                    cubit.isDark ? Colors.black : Colors.white,
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
                          color: cubit.isDark ? Colors.black : Colors.white,
                          size: 30.sp,
                        ),
                        space(10.w, 0),
                        Text(
                          "Save Post",
                          style: TextStyle(
                            color: cubit.isDark ? Colors.black : Colors.white,
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
                            color: cubit.isDark ? Colors.black : Colors.white,
                            size: 30.sp,
                          ),
                          space(10.w, 0),
                          Text(
                            "Save Image",
                            style: TextStyle(
                              color: cubit.isDark ? Colors.black : Colors.white,
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
                          color: cubit.isDark ? Colors.black : Colors.white,
                          size: 30.sp,
                        ),
                        space(10.w, 0),
                        Text(
                          "Share",
                          style: TextStyle(
                            color: cubit.isDark ? Colors.black : Colors.white,
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
                            color: cubit.isDark ? Colors.black : Colors.white,
                            size: 30.sp,
                          ),
                          space(10.w, 0),
                          Text(
                            "Delete Post",
                            style: TextStyle(
                              color: cubit.isDark ? Colors.black : Colors.white,
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
  }
}
