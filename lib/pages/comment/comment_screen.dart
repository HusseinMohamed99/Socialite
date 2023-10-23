import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialite/image_assets.dart';
import 'package:socialite/model/comment_model.dart';
import 'package:socialite/model/post_model.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/pages/post_like/likes_screen.dart';
import 'package:socialite/shared/components/my_divider.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';
import 'package:socialite/shared/widget/build_comments_widget.dart';

class CommentsScreen extends StatelessWidget {
  final int likes;
  final String postId;
  final String postUid;
  const CommentsScreen({
    super.key,
    required this.likes,
    required this.postId,
    required this.postUid,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        dynamic commentImage = SocialCubit.get(context).commentImage;
        PostModel? post = SocialCubit.get(context).singlePost;
        List<CommentModel> comments = SocialCubit.get(context).comments;
        UserModel? user = SocialCubit.get(context).userModel;
        SocialCubit cubit = SocialCubit.get(context);
        TextEditingController commentTextControl = TextEditingController();
        String? postId = this.postId;
        var formKey = GlobalKey<FormState>();
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              AppString.comment,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(letterSpacing: 10),
            ),
            elevation: 0,
          ),
          body: Form(
            key: formKey,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ListView(
                  children: [
                    InkWell(
                      onTap: () {
                        navigateTo(context, LikesScreen(postID: postId));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p20),
                        child: Row(
                          children: [
                            const Icon(
                              IconlyBroken.heart,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '$likes',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: ColorManager.dividerColor),
                            ),
                            const Spacer(),
                            const Icon(IconlyBroken.arrowRightCircle),
                          ],
                        ),
                      ),
                    ),
                    const MyDivider(vertical: AppPadding.p16),
                    ConditionalBuilder(
                      condition: comments.isNotEmpty,
                      builder: (context) => Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) =>
                              BuildCommentsItem(comment: comments[index]),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10.h),
                          itemCount: cubit.comments.length,
                        ),
                      ),
                      fallback: (context) => Center(
                        child: SvgPicture.asset(Assets.imagesUndrawNotFound),
                      ),
                    ),
                    if (cubit.isCommentImageLoading)
                      const LinearProgressIndicator(
                        color: Colors.blueAccent,
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
                                width: 200,
                                height: 200,
                                child: Image.file(
                                  commentImage,
                                  fit: BoxFit.fitWidth,
                                  width: 200,
                                ),
                              ),
                              const SizedBox(width: 5),
                              CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).popCommentImage();
                                  },
                                  icon: const Icon(IconlyBroken.closeSquare),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                if (cubit.comments.isEmpty)
                  const SizedBox(
                    height: 200,
                  ),
                TextFormField(
                  controller: commentTextControl,
                  autofocus: false,
                  textAlignVertical: TextAlignVertical.center,
                  style: Theme.of(context).textTheme.titleLarge,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return AppString.noComments;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: AppString.comment,
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
                          icon: const Icon(
                            IconlyBroken.camera,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              commentMethod(
                                commentImage,
                                context,
                                postId,
                                commentTextControl,
                                post,
                                user,
                              );
                            }
                          },
                          icon: const Icon(
                            IconlyBroken.send,
                            color: ColorManager.blueColor,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    filled: true,
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: ColorManager.dividerColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: ColorManager.dividerColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: ColorManager.dividerColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void commentMethod(
    commentImage,
    BuildContext context,
    String postId,
    TextEditingController commentTextControl,
    PostModel? post,
    UserModel? user,
  ) {
    if (commentImage == null) {
      SocialCubit.get(context).commentPost(
        postId: postId,
        comment: commentTextControl.text,
        time: DateTime.now(),
      );
    } else {
      SocialCubit.get(context).uploadCommentImage(
        postId: postId,
        commentText:
            commentTextControl.text == '' ? null : commentTextControl.text,
        time: DateTime.now(),
      );
    }
    SocialCubit.get(context).sendInAppNotification(
      receiverName: post!.name,
      receiverId: post.uId,
      content: AppString.commentedOnPost,
      contentId: postId,
      contentKey: AppString.post,
    );
    SocialCubit.get(context).sendFCMNotification(
      token: user!.token,
      senderName: SocialCubit.get(context).userModel!.name,
      messageText: '${SocialCubit.get(context).userModel!.name}'
          '${AppString.commentedOnPost}',
    );
    commentTextControl.clear();
    SocialCubit.get(context).popCommentImage();
  }
}
