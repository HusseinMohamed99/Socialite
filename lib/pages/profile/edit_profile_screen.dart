import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/components/show_toast.dart';
import 'package:socialite/shared/components/text_form_field.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController bioController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController portfolioController = TextEditingController();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is UpdateUserSuccessState) {
          showToast(
            text: AppString.updateDataSuccessfully,
            state: ToastStates.success,
          );
        }
      },
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        File? profileImage = SocialCubit.get(context).profileImage;
        File? coverImage = SocialCubit.get(context).coverImage;
        var cubit = SocialCubit.get(context);
        emailController.text = userModel!.email!;
        bioController.text = userModel.bio!;
        nameController.text = userModel.name!;
        phoneController.text = userModel.phone!;
        portfolioController.text = userModel.portfolio!;

        return SocialCubit.get(context).userModel == null
            ? Scaffold(
                body: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        IconlyBroken.infoSquare,
                        size: 100.sp,
                        color: ColorManager.greyColor,
                      ),
                      Text(
                        'User Nullable',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              )
            : Scaffold(
                body: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 220.h,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.topCenter,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional.topCenter,
                                          child: coverImage == null
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8),
                                                      topRight:
                                                          Radius.circular(8),
                                                    ).r,
                                                  ),
                                                  width: double.infinity,
                                                  height: 200.h,
                                                  child: imagePreview(
                                                    userModel.cover,
                                                  ),
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: FileImage(
                                                        coverImage,
                                                      ),
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8),
                                                      topRight:
                                                          Radius.circular(8),
                                                    ).r,
                                                  ),
                                                  width: double.infinity,
                                                  height: 200.h,
                                                  child: imagePreview(
                                                    userModel.cover,
                                                  ),
                                                ),
                                        ),
                                        Positioned(
                                          bottom: 30.h,
                                          right: 10.w,
                                          child: CircleAvatar(
                                            radius: 22.r,
                                            backgroundColor:
                                                ColorManager.greyColor,
                                            child: IconButton(
                                              splashRadius: 1,
                                              onPressed: () {
                                                cubit.getCoverImage();
                                              },
                                              icon: Icon(
                                                IconlyBroken.camera,
                                                color:
                                                    ColorManager.titanWithColor,
                                                size: 30.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      profileImage == null
                                          ? CircleAvatar(
                                              backgroundColor:
                                                  ColorManager.dividerColor,
                                              radius: 75.r,
                                              child: CircleAvatar(
                                                radius: 70.r,
                                                child: imageWithShimmer(
                                                  userModel.image,
                                                  radius: 65.r,
                                                ),
                                              ),
                                            )
                                          : CircleAvatar(
                                              backgroundColor:
                                                  ColorManager.dividerColor,
                                              radius: 75.r,
                                              child: CircleAvatar(
                                                radius: 70.r,
                                                backgroundImage:
                                                    FileImage(profileImage),
                                              ),
                                            ),
                                      Positioned(
                                        top: 90.h,
                                        left: 95.w,
                                        child: CircleAvatar(
                                          radius: 22.r,
                                          backgroundColor:
                                              ColorManager.greyColor,
                                          child: IconButton(
                                            splashRadius: 1,
                                            onPressed: () {
                                              cubit.getProfileImage();
                                            },
                                            icon: Icon(
                                              IconlyBroken.camera,
                                              color:
                                                  ColorManager.titanWithColor,
                                              size: 30.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 30.h,
                                    left: 5.w,
                                    child: IconButton(
                                      onPressed: () {
                                        pop(context);
                                      },
                                      icon: CircleAvatar(
                                        backgroundColor:
                                            ColorManager.greyDarkColor,
                                        child: Icon(
                                          IconlyBroken.arrowLeft2,
                                          size: 24.sp,
                                          color: ColorManager.titanWithColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  DefaultTextFormField(
                                    controller: nameController,
                                    keyboardType: TextInputType.name,
                                    validate: (String? value) {
                                      if (value!.trim().isEmpty) {
                                        return AppString.enterEmail;
                                      }
                                      return null;
                                    },
                                    label: AppString.name,
                                    prefix: IconlyBroken.user3,
                                    textColor: cubit.isDark
                                        ? ColorManager.blackColor
                                        : ColorManager.titanWithColor,
                                  ),
                                  SizedBox(height: 15.h),
                                  DefaultTextFormField(
                                    controller: bioController,
                                    keyboardType: TextInputType.text,
                                    validate: (String? value) {
                                      if (value!.trim().isEmpty) {
                                        return AppString.enterBio;
                                      }
                                      return null;
                                    },
                                    label: AppString.bio,
                                    prefix: IconlyBroken.infoSquare,
                                    textColor: cubit.isDark
                                        ? ColorManager.blackColor
                                        : ColorManager.titanWithColor,
                                  ),
                                  SizedBox(height: 15.h),
                                  DefaultTextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validate: (String? value) {
                                      if (value!.trim().isEmpty) {
                                        return AppString.enterEmail;
                                      }
                                      return null;
                                    },
                                    label: AppString.emailAddress,
                                    prefix: IconlyBroken.message,
                                    textColor: cubit.isDark
                                        ? ColorManager.blackColor
                                        : ColorManager.titanWithColor,
                                  ),
                                  SizedBox(height: 15.h),
                                  DefaultTextFormField(
                                    controller: phoneController,
                                    keyboardType: TextInputType.phone,
                                    validate: (String? value) {
                                      if (value!.trim().isEmpty) {
                                        return AppString.egyptianNumber;
                                      }
                                      return null;
                                    },
                                    label: AppString.phone,
                                    prefix: IconlyBroken.calling,
                                    textColor: cubit.isDark
                                        ? ColorManager.blackColor
                                        : ColorManager.titanWithColor,
                                  ),
                                  SizedBox(height: 15.h),
                                  DefaultTextFormField(
                                    controller: portfolioController,
                                    keyboardType: TextInputType.url,
                                    validate: (String? value) {
                                      if (value!.trim().isEmpty) {
                                        return AppString.enterPortfolio;
                                      }
                                      return null;
                                    },
                                    label: AppString.portfolio,
                                    prefix: IconlyBroken.document,
                                    textColor: cubit.isDark
                                        ? ColorManager.blackColor
                                        : ColorManager.titanWithColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 30.h,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: cubit.isDark
                                        ? ColorManager.titanWithColor
                                        : ColorManager.primaryColor,
                                  ),
                                  onPressed: () {
                                    if (cubit.coverImage != null &&
                                        cubit.profileImage == null) {
                                      cubit.uploadCoverImage(
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        name: nameController.text,
                                        bio: bioController.text,
                                        portfolio: portfolioController.text,
                                      );
                                    } else if (cubit.profileImage != null &&
                                        cubit.coverImage == null) {
                                      cubit.uploadProfileImage(
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        name: nameController.text,
                                        bio: bioController.text,
                                        portfolio: portfolioController.text,
                                      );
                                    } else if (cubit.profileImage == null &&
                                        cubit.coverImage == null) {
                                      cubit.updateUserData(
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        name: nameController.text,
                                        bio: bioController.text,
                                        portfolio: portfolioController.text,
                                      );
                                    } else if (cubit.coverImage != null &&
                                        cubit.profileImage != null) {
                                      cubit.uploadProfileAndCoverImage(
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        name: nameController.text,
                                        bio: bioController.text,
                                        portfolio: portfolioController.text,
                                      );
                                    }
                                  },
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Text(
                                    AppString.update.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (state is UpdateUserLoadingState)
                      const LinearProgressIndicator(),
                  ],
                ),
              );
      },
    );
  }
}
