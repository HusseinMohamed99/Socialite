import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociality/model/comment_model.dart';
import 'package:sociality/model/post_model.dart';
import 'package:sociality/model/user_model.dart';
import 'package:sociality/pages/post_like/likes_screen.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:sociality/shared/components/image_with_shimmer.dart';
import 'package:sociality/shared/components/my_divider.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/cubit/socialCubit/social_state.dart';
import 'package:sociality/shared/styles/color.dart';

class CommentsScreen extends StatelessWidget {
  final int? likes;
  final String? postId;
  final String? postUid;
  const CommentsScreen({super.key, this.likes, this.postId, this.postUid});

  @override
  Widget build(BuildContext context) {
    var commentTextControl = TextEditingController();
    String? postId = this.postId;
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getSinglePost(postId);
        SocialCubit.get(context).getComments(postId);
        SocialCubit.get(context).getUserData();
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            dynamic commentImage = SocialCubit.get(context).commentImage;
            PostModel? post = SocialCubit.get(context).singlePost;
            List<CommentModel> comments = SocialCubit.get(context).comments;
            UserModel? user = SocialCubit.get(context).userModel;
            SocialCubit cubit = SocialCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Comments',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                automaticallyImplyLeading: true,
                leading: IconButton(
                  onPressed: () {
                    comments.clear();
                    pop(context);
                  },
                  icon: Icon(
                    IconlyLight.arrowLeft2,
                    size: 30.sp,
                    color: cubit.isDark
                        ? AppMainColors.blackColor
                        : AppMainColors.titanWithColor,
                  ),
                ),
                elevation: 0,
              ),
              body: Padding(
                padding: const EdgeInsets.all(15).r,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        navigateTo(context, LikesScreen(postId));
                      },
                      child: Row(
                        children: [
                          Icon(
                            IconlyBroken.heart,
                            color: Colors.red,
                            size: 24.sp,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            '$likes',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: AppMainColors.dividerColor),
                          ),
                          const Spacer(),
                          Icon(IconlyBroken.arrowRightCircle, size: 24.sp),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    comments.isNotEmpty
                        ? Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) =>
                                  BuildCommentsItem(comment: comments[index]),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10.h),
                              itemCount:
                                  SocialCubit.get(context).comments.length,
                            ),
                          )
                        : Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "No comments yet,\nPut your comment",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    "First Comment 💬",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  )
                                ],
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SocialCubit.get(context).isCommentImageLoading
                          ? const LinearProgressIndicator(
                              color: Colors.blueAccent,
                            )
                          : const MyDivider(),
                    ),
                    if (commentImage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8).r,
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100.w,
                                height: 100.h,
                                child: Image.file(
                                  commentImage,
                                  fit: BoxFit.fitWidth,
                                  width: 100.w,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              SizedBox(
                                width: 30.w,
                                height: 30.h,
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[300],
                                  child: IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context)
                                          .popCommentImage();
                                    },
                                    icon: Icon(Icons.close, size: 15.sp),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 35.h,
                      child: TextFormField(
                        controller: commentTextControl,
                        autofocus: true,
                        textAlignVertical: TextAlignVertical.center,
                        style: Theme.of(context).textTheme.titleLarge,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "The comment can't be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20).r,
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(10).r,
                          hintText: 'comment..',
                          hintStyle: Theme.of(context).textTheme.titleLarge,
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    SocialCubit.get(context).getCommentImage();
                                  },
                                  icon: Icon(
                                    IconlyBroken.camera,
                                    color: Colors.grey,
                                    size: 24.sp,
                                  )),
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  if (commentImage == null) {
                                    SocialCubit.get(context).commentPost(
                                      postId: postId!,
                                      comment: commentTextControl.text,
                                      time: DateTime.now(),
                                    );
                                  } else {
                                    SocialCubit.get(context).uploadCommentImage(
                                      postId: postId!,
                                      commentText: commentTextControl.text == ''
                                          ? null
                                          : commentTextControl.text,
                                      time: DateTime.now(),
                                    );
                                  }
                                  SocialCubit.get(context)
                                      .sendInAppNotification(
                                          receiverName: post!.name,
                                          receiverId: post.uId,
                                          content:
                                              'commented on a post you shared',
                                          contentId: postId,
                                          contentKey: 'post');
                                  SocialCubit.get(context).sendFCMNotification(
                                    token: user!.token,
                                    senderName: SocialCubit.get(context)
                                        .userModel!
                                        .name,
                                    messageText:
                                        '${SocialCubit.get(context).userModel!.name}'
                                        ' commented on a post you shared',
                                  );
                                  commentTextControl.clear();
                                  SocialCubit.get(context).popCommentImage();
                                },
                                icon: Icon(
                                  IconlyBroken.send,
                                  color: AppMainColors.blueColor,
                                  size: 24.sp,
                                ),
                              ),
                            ],
                          ),
                          filled: true,
                          fillColor: AppMainColors.greyColor.withOpacity(0.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20).r,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class BuildCommentsItem extends StatelessWidget {
  const BuildCommentsItem({super.key, required this.comment});
  final CommentModel comment;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20.r,
              child: ImageWithShimmer(
                imageUrl: '${comment.userImage}',
                width: 50.w,
                height: 50.h,
                boxFit: BoxFit.fill,
                radius: 15.r,
              ),
            ),
            SizedBox(width: 5.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                comment.commentText != null && comment.commentImage != null
                    ?

                    /// If its (Text & Image) Comment
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ).r,
                            decoration: BoxDecoration(
                              color: AppMainColors.greyColor.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(15).r,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${comment.name}',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  '${comment.commentText}',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Container(
                              width: intToDouble(
                                  comment.commentImage?['width'] ?? 250),
                              height: intToDouble(
                                  comment.commentImage?['height'] ?? 250),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15).r,
                              ),
                              child:
                                  imagePreview(comment.commentImage!['image'])),
                        ],
                      )
                    : comment.commentImage != null
                        ?

                        /// If its (Image) Comment
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${comment.name}',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Container(
                                  width: intToDouble(
                                      comment.commentImage?['width'] ?? 250),
                                  height: intToDouble(
                                      comment.commentImage?['height'] ?? 250),
                                  decoration: BoxDecoration(
                                    color: AppMainColors.greyColor
                                        .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(15).r,
                                  ),
                                  child: imagePreview(
                                      comment.commentImage!['image'])),
                            ],
                          )
                        : comment.commentText != null
                            ?

                            /// If its (Text) Comment
                            Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ).r,
                                decoration: BoxDecoration(
                                  color:
                                      AppMainColors.greyColor.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(15).r,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${comment.name}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      '${comment.commentText}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                Padding(
                  padding: const EdgeInsets.only(left: 8).r,
                  child: Text(
                    '${comment.dateTime}',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.end,
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
