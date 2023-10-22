import 'dart:io';
import 'package:flutter/services.dart';
import 'package:socialite/model/user_model.dart';
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
import 'package:socialite/shared/utils/value_manager.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController bioController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController portfolioController = TextEditingController();
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double screenHeight = MediaQuery.sizeOf(context).height;
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
        UserModel? userModelData = SocialCubit.get(context).userModel;
        File? profileImage = SocialCubit.get(context).profileImage;
        File? coverImage = SocialCubit.get(context).coverImage;
        SocialCubit cubit = SocialCubit.get(context);
        emailController.text = userModelData!.email;
        bioController.text = userModelData.bio;
        nameController.text = userModelData.name;
        phoneController.text = userModelData.phone;
        portfolioController.text = userModelData.portfolio;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
          child: Scaffold(
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: screenHeight * .3,
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
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                ),
                                                width: double.infinity,
                                                height: screenHeight * .3,
                                                child: imagePreview(
                                                  userModelData.cover,
                                                ),
                                              )
                                            : Container(
                                                height: screenHeight * .3,
                                                width: screenWidth,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: FileImage(
                                                      coverImage,
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                ),
                                                child: imagePreview(
                                                  userModelData.cover,
                                                ),
                                              ),
                                      ),
                                      Positioned(
                                        bottom: screenHeight * .01,
                                        right: screenHeight * .01,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              ColorManager.greyColor,
                                          child: IconButton(
                                            splashRadius: 1,
                                            onPressed: () {
                                              cubit.getCoverImage();
                                            },
                                            icon: const Icon(
                                              IconlyBroken.camera,
                                              color:
                                                  ColorManager.titanWithColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * .1),
                          Padding(
                            padding: const EdgeInsets.all(AppPadding.p12),
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
                                ),
                                const SizedBox(height: 20),
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
                                ),
                                const SizedBox(height: 20),
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
                                ),
                                const SizedBox(height: 20),
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
                                ),
                                const SizedBox(height: 20),
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
                                  prefix: IconlyBroken.paper,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: screenHeight * .2,
                        right: screenWidth * .3,
                        child: Stack(
                          children: [
                            profileImage == null
                                ? CircleAvatar(
                                    backgroundColor: ColorManager.dividerColor,
                                    radius: 75,
                                    child: CircleAvatar(
                                      radius: 70,
                                      child: imageWithShimmer(
                                        userModelData.image,
                                        radius: 65,
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundColor: ColorManager.dividerColor,
                                    radius: 75,
                                    child: CircleAvatar(
                                      radius: 70,
                                      backgroundImage: FileImage(profileImage),
                                    ),
                                  ),
                            Positioned(
                              bottom: screenHeight * .01,
                              right: screenWidth * .01,
                              child: CircleAvatar(
                                backgroundColor: ColorManager.greyColor,
                                child: IconButton(
                                  onPressed: () {
                                    cubit.getProfileImage();
                                  },
                                  icon: const Icon(
                                    IconlyBroken.camera,
                                    color: ColorManager.titanWithColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: screenHeight * .1)),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: cubit.isDark
                                      ? ColorManager.titanWithColor
                                      : ColorManager.primaryColor,
                                ),
                                onPressed: () {
                                  updateUserData(
                                    cubit,
                                    emailController,
                                    phoneController,
                                    nameController,
                                    bioController,
                                    portfolioController,
                                  );
                                },
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Text(
                                  AppString.update.toUpperCase(),
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (state is UpdateUserLoadingState)
                  const SliverToBoxAdapter(
                      child: LinearProgressIndicator(
                    value: 0.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        ColorManager.dividerColor),
                    color: ColorManager.primaryColor,
                    backgroundColor: ColorManager.dividerColor,
                  )),
              ],
            ),
          ),
        );
      },
    );
  }

  void updateUserData(
      SocialCubit cubit,
      TextEditingController emailController,
      TextEditingController phoneController,
      TextEditingController nameController,
      TextEditingController bioController,
      TextEditingController portfolioController) {
    if (cubit.coverImage != null && cubit.profileImage == null) {
      cubit.uploadCoverImage(
        email: emailController.text,
        phone: phoneController.text,
        name: nameController.text,
        bio: bioController.text,
        portfolio: portfolioController.text,
      );
    } else if (cubit.profileImage != null && cubit.coverImage == null) {
      cubit.uploadProfileImage(
        email: emailController.text,
        phone: phoneController.text,
        name: nameController.text,
        bio: bioController.text,
        portfolio: portfolioController.text,
      );
    } else if (cubit.profileImage == null && cubit.coverImage == null) {
      cubit.updateUserData(
        email: emailController.text,
        phone: phoneController.text,
        name: nameController.text,
        bio: bioController.text,
        portfolio: portfolioController.text,
      );
    } else if (cubit.coverImage != null && cubit.profileImage != null) {
      cubit.uploadProfileAndCoverImage(
        email: emailController.text,
        phone: phoneController.text,
        name: nameController.text,
        bio: bioController.text,
        portfolio: portfolioController.text,
      );
    }
  }
}
