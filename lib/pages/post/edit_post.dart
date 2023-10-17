import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/model/post_model.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/components/show_toast.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialite/shared/utils/color_manager.dart';

class EditPosts extends StatelessWidget {
  final PostModel postModel;
  final String postId;

  final TextEditingController post = TextEditingController();

  EditPosts({Key? key, required this.postModel, required this.postId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      post.text = postModel.text!;

      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          if (state is EditPostSuccessState) {
            Navigator.pop(context);
            SocialCubit.get(context).removePostImage();
            showToast(
                text: 'Your post is Edited successfully',
                state: ToastStates.success);
          }
        },
        builder: (context, state) {
          SocialCubit cubit = SocialCubit.get(context);
          UserModel userModel = SocialCubit.get(context).userModel!;
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  pop(context);
                  cubit.removePostImage();
                },
                icon: Icon(
                  IconlyLight.arrowLeft2,
                  size: 24.sp,
                  color: cubit.isDark
                      ? ColorManager.blackColor
                      : ColorManager.titanWithColor,
                ),
              ),
              titleSpacing: 1,
              title: Text(
                'Edit Your Post',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    DateTime now = DateTime.now();
                    if (cubit.postImagePicked == null) {
                      cubit.editPost(
                        postModel: postModel,
                        postId: postId,
                        text: post.text,
                        dateTime: now.toString(),
                      );
                    } else {
                      cubit.editPostWithImage(
                        postModel: postModel,
                        postId: postId,
                        text: post.text,
                        dateTime: now.toString(),
                      );
                    }
                  },
                  child: Text(
                    'Update',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      if (state is CreatePostLoadingState)
                        const LinearProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          left: 20,
                        ).r,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25.r,
                              child: ImageWithShimmer(
                                radius: 20.r,
                                imageUrl: userModel.image,
                                width: 50.w,
                                height: 50.h,
                                boxFit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userModel.name,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      IconlyLight.user2,
                                      color: cubit.isDark
                                          ? Colors.black
                                          : Colors.white,
                                      size: 14.sp,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      'public',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: ColorManager.greyColor,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20).r,
                        child: TextFormField(
                          maxLines: 6,
                          minLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: ColorManager.blackColor),
                          controller: post,
                          decoration: InputDecoration(
                            hintText: "' What's on your mind ? '",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: ColorManager.greyColor,
                                ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (cubit.postImagePicked != null ||
                          postModel.postImage != '')
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10).r,
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorManager.greyColor
                                          .withOpacity(0.4),
                                    ),
                                  ],
                                ),
                                child: cubit.postImagePicked != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image(
                                          image:
                                              FileImage(cubit.postImagePicked!),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image(
                                          image: NetworkImage(
                                              postModel.postImage!),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.removePostImage();
                                postModel.postImage = '';
                              },
                              icon: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorManager.greyColor
                                          .withOpacity(0.4),
                                      blurRadius: 9,
                                      spreadRadius: 4,
                                      offset: const Offset(0, 4),
                                    )
                                  ],
                                ),
                                child: CircleAvatar(
                                  backgroundColor: ColorManager.redColor,
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: Colors.white,
                                    size: 24.sp,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                    ],
                  ),
                ),
                const Spacer(),
                if (cubit.postImagePicked == null && postModel.postImage == '')
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 30.h,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: cubit.isDark
                                  ? ColorManager.titanWithColor
                                  : ColorManager.primaryColor,
                            ),
                            onPressed: () {
                              cubit.getPostImage();
                            },
                            label: Text(
                              'Add photo'.toUpperCase(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            icon: Icon(
                              IconlyLight.image,
                              color: ColorManager.titanWithColor,
                              size: 24.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      );
    });
  }
}
