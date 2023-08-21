import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sociality/model/post_model.dart';
import 'package:sociality/model/user_model.dart';
import 'package:sociality/pages/comment/comment_screen.dart';
import 'package:sociality/pages/friend/friends_profile_screen.dart';
import 'package:sociality/pages/post_like/likes_screen.dart';
import 'package:sociality/pages/profile/my_profile_screen.dart';
import 'package:sociality/pages/viewPhoto/post_view.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:sociality/shared/components/image_with_shimmer.dart';
import 'package:sociality/shared/components/my_divider.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/styles/color.dart';
import 'package:sociality/shared/widget/more_options.dart';

class BuildPostItem extends StatelessWidget {
  const BuildPostItem(
      {super.key,
      required this.postModel,
      required this.index,
      required this.userModel});

  final PostModel postModel;
  final int index;
  final UserModel userModel;
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
                      SocialCubit.get(context).getUserPosts(postModel.uId);
                    } else {
                      SocialCubit.get(context).getUserPosts(postModel.uId);
                      SocialCubit.get(context).getUserData();

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
                      imageUrl: postModel.image!,
                      width: 100.w,
                      height: 100.h,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
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
                                SocialCubit.get(context).getUserPosts(uId);
                                SocialCubit.get(context).getUserData();
                                navigateTo(
                                  context,
                                  const MyProfileScreen(),
                                );
                              }
                            },
                            child: Text(
                              postModel.name!,
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
                              DateTime.parse(
                                postModel.dateTime.toString(),
                              ),
                            ),
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
                    moreOption(context, cubit, postId, postModel);
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
                    '${postModel.comments}',
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
                      radius: 25.r,
                      imageUrl: SocialCubit.get(context).userModel!.image,
                      width: 40.w,
                      height: 40.h,
                      boxFit: BoxFit.fill,
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
                    DateTime now = DateTime.now();
                    await SocialCubit.get(context).likeByMe(
                      postUser: postUser,
                      context: context,
                      postModel: postModel,
                      postId: postId = SocialCubit.get(context).postsId[index],
                      dataTime: now.toString(),
                    );
                  },
                  label: Text(
                    'Like',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: AppMainColors.redColor),
                  ),
                  icon: Icon(
                    IconlyLight.heart,
                    color: AppMainColors.redColor,
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
}
