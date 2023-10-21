import 'package:socialite/model/user_model.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/components/indicator.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/components/show_toast.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    SocialCubit cubit = SocialCubit.get(context);
    UserModel userModel = SocialCubit.get(context).userModel!;
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is CreatePostLoadingState) {
          const AdaptiveIndicator();
        }
        if (state is CreatePostSuccessState) {
          cubit.getPosts();
          pop(context);
          showToast(
              text: AppString.createPostSuccessfully,
              state: ToastStates.success);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                pop(context);
                cubit.removePostImage();
              },
              icon: const Icon(
                IconlyBroken.arrowLeft2,
              ),
            ),
            title: Text(
              AppString.createPost,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  sharePost(textController, cubit, context);
                },
                child: Text(
                  AppString.share,
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
                  Form(
                    key: formKey,
                    child: Column(
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
                              SizedBox(width: 10.w),
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
                                      SizedBox(width: 5.w),
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
                        SizedBox(height: 10.h),
                        TextFieldForm(textController: textController),
                        if (SocialCubit.get(context).postImagePicked != null)
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
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                      image: FileImage(cubit.postImagePicked!),
                                      fit: BoxFit.fitWidth,
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
                                      Icons.close_rounded,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                      ],
                    ),
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
  }

  void sharePost(TextEditingController textController, SocialCubit cubit,
      BuildContext context) {
    DateTime now = DateTime.now();
    if (textController.text.trim().isNotEmpty &&
        cubit.postImagePicked == null) {
      cubit.createPost(
        dateTime: now,
        text: textController.text,
      );
      cubit.removePostImage();
    } else if (cubit.postImagePicked != null) {
      cubit.uploadPostImage(
        dateTime: now,
        text: textController.text,
      );
      pop(context);
      cubit.removePostImage();
    } else {
      pop(context);
    }
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
      padding: const EdgeInsets.symmetric(horizontal: 20).r,
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
