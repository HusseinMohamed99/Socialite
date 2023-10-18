import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialite/model/post_model.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/pages/comment/comment_screen.dart';
import 'package:socialite/pages/friend/friends_profile_screen.dart';
import 'package:socialite/pages/post_like/likes_screen.dart';
import 'package:socialite/pages/profile/user_profile_screen.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/components/my_divider.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/components/show_toast.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/widget/more_options.dart';

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
                        FriendsProfileScreen(userModel.uId),
                      );

                      SocialCubit.get(context).getFriendsProfile(postModel.uId);
                      SocialCubit.get(context).getUserPosts(postModel.uId);
                    } else {
                      SocialCubit.get(context).getUserPosts(postModel.uId);
                      SocialCubit.get(context).getUserData();

                      navigateTo(
                        context,
                        const UserProfileScreen(),
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
                                  const UserProfileScreen(),
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
                                .copyWith(color: ColorManager.greyColor),
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
                    IconlyBroken.moreCircle,
                    size: 24.sp,
                    color: ColorManager.greyColor,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0).r,
              child: MyDivider(color: ColorManager.greyColor.withOpacity(0.5)),
            ),
            Text(
              '${postModel.text}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (postModel.postImage != '')
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15).r,
                      child: imagePreview(
                        '${postModel.postImage}',
                      ),
                    ),
                  ),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                    cubit.getLikes(postId);
                    navigateTo(
                      context,
                      LikesScreen(
                        SocialCubit.get(context).postsId[index],
                      ),
                    );
                  },
                  icon: Icon(
                    IconlyBroken.heart,
                    color: Colors.red,
                    size: 24.sp,
                  ),
                  label: Text(
                    '${postModel.likes}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: ColorManager.redColor),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    navigateTo(
                      context,
                      CommentsScreen(
                        likes: postModel.likes,
                        postId: postModel.postId,
                        postUid: postModel.uId,
                      ),
                    );
                    cubit.getComments(SocialCubit.get(context).postsId[index]);
                  },
                  icon: Icon(
                    IconlyBroken.chat,
                    color: Colors.orangeAccent,
                    size: 24.sp,
                  ),
                  label: Text(
                    '${postModel.comments}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: ColorManager.orangeColor),
                  ),
                ),
              ],
            ),
            MyDivider(
              color: ColorManager.greyColor.withOpacity(0.4),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    navigateTo(context, const UserProfileScreen());
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
                        likes: postModel.likes,
                        postId: postModel.postId,
                        postUid: postModel.uId,
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 120.w,
                    child: Text(
                      AppString.writeComment,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: ColorManager.greyColor),
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
                      postId: postId,
                      dataTime: now,
                    );
                  },
                  label: Text(
                    AppString.likes,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: ColorManager.redColor,
                        ),
                  ),
                  icon: Icon(
                    IconlyBroken.heart,
                    color: ColorManager.redColor,
                    size: 24.sp,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    SocialCubit.get(context).createPost(
                      userName: SocialCubit.get(context).userModel!.name,
                      profileImage: SocialCubit.get(context).userModel!.image,
                      text: postModel.text!,
                      postImage: postModel.postImage,
                      dateTime: DateTime.now(),
                    );
                    showToast(
                      text: AppString.sharedPostSuccessfully,
                      state: ToastStates.success,
                    );
                  },
                  icon: Icon(
                    IconlyBroken.upload,
                    color: Colors.green,
                    size: 24.sp,
                  ),
                  label: Text(
                    AppString.share,
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
