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
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';

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
              text: AppString.editPostSuccessfully,
              state: ToastStates.success,
            );
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
                  IconlyBroken.arrowLeft2,
                  color: cubit.isDark
                      ? ColorManager.blackColor
                      : ColorManager.titanWithColor,
                ),
              ),
              titleSpacing: 1,
              title: Text(
                AppString.editPost,
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
                    AppString.update,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ListView(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(AppPadding.p16),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 32,
                                backgroundColor: ColorManager.dividerColor,
                                child: ImageWithShimmer(
                                  radius: 30,
                                  imageUrl: userModel.image,
                                  width: 60,
                                  height: 60,
                                  boxFit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userModel.name,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        IconlyLight.user2,
                                        color: cubit.isDark
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        AppString.public,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFieldForm(textController: post),
                        if (SocialCubit.get(context).postImagePicked != null ||
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image(
                                            image: FileImage(
                                                cubit.postImagePicked!),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image(
                                            image: NetworkImage(
                                              postModel.postImage!,
                                            ),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.removePostImage();
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
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: const Icon(
                                      IconlyBold.closeSquare,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                          ),
                          onPressed: () {
                            cubit.getPostImage();
                          },
                          label: Text(
                            AppString.addPhoto.toUpperCase(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          icon: Icon(
                            IconlyBroken.image,
                            color: cubit.isDark
                                ? ColorManager.scaffoldBackgroundDarkColor
                                : ColorManager.scaffoldBackgroundColor,
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

class TextFieldForm extends StatelessWidget {
  const TextFieldForm({
    super.key,
    required this.textController,
  });

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: 20,
        minLines: 1,
        style: Theme.of(context).textTheme.titleLarge,
        controller: textController,
        decoration: InputDecoration(
          hintText: AppString.yourMind,
          hintStyle: Theme.of(context).textTheme.titleMedium,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
