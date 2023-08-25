import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociality/Pages/friend/friend_screen.dart';
import 'package:sociality/Pages/profile/edit_profile_screen.dart';
import 'package:sociality/shared/components/indicator.dart';
import 'package:sociality/model/user_model.dart';
import 'package:sociality/shared/components/my_divider.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/components/show_toast.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/cubit/socialCubit/social_state.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:sociality/shared/styles/color.dart';
import 'package:sociality/shared/widget/build_post_item.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SavedToGalleryLoadingState) {
          Navigator.pop(context);
        }
        if (state is SavedToGallerySuccessState) {
          showToast(text: "Downloaded to Gallery!", state: ToastStates.success);
        }

        if (state is LikesSuccessState) {
          showToast(text: "Likes Success!", state: ToastStates.success);
        }

        if (state is DisLikesSuccessState) {
          showToast(text: "UnLikes Success!", state: ToastStates.warning);
        }
      },
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        SocialCubit cubit = SocialCubit.get(context);
        return SocialCubit.get(context).userModel == null
            ? Scaffold(
                body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      IconlyLight.infoSquare,
                      size: 100.sp,
                      color: AppMainColors.greyColor,
                    ),
                    Text(
                      'No Posts yet',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const CircularProgressIndicator(),
                  ],
                ),
              ))
            : AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                ),
                child: Scaffold(
                  body: cubit.userPosts.isEmpty
                      ? ProfileInfo(userModel: userModel, cubit: cubit)
                      : ConditionalBuilder(
                          condition: cubit.userPosts.isNotEmpty,
                          builder: (BuildContext context) =>
                              SingleChildScrollView(
                            child: Column(
                              children: [
                                ProfileInfo(userModel: userModel, cubit: cubit),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10.0,
                                    right: 10,
                                    top: 10,
                                  ).r,
                                  child: Align(
                                    alignment: AlignmentDirectional.topStart,
                                    child: Text(
                                      'Posts',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                  ),
                                ),
                                ListView.separated(
                                  padding: const EdgeInsets.only(top: 10).r,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: cubit.userPosts.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 10.h),
                                  itemBuilder: (context, index) =>
                                      (BuildPostItem(
                                    postModel: cubit.userPosts[index],
                                    userModel: cubit.userModel!,
                                    index: index,
                                  )),
                                ),
                              ],
                            ),
                          ),
                          fallback: (BuildContext context) => Center(
                            child: AdaptiveIndicator(
                              os: getOs(),
                            ),
                          ),
                        ),
                ),
              );
      },
    );
  }
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
    required this.userModel,
    required this.cubit,
  });

  final UserModel? userModel;
  final SocialCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 220.h,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ).r,
                  ),
                  width: double.infinity,
                  height: 230,
                  child: imagePreview(
                    userModel!.cover,
                  ),
                ),
              ),
              CircleAvatar(
                backgroundColor: AppMainColors.dividerColor,
                radius: 75.r,
                child: CircleAvatar(
                  radius: 70.r,
                  child: imagePreview(userModel!.image, radius: 65.r),
                ),
              ),
              Positioned(
                top: 30.h,
                left: 5.w,
                child: IconButton(
                  onPressed: () {
                    pop(context);
                  },
                  icon: CircleAvatar(
                    backgroundColor: AppMainColors.greyDarkColor,
                    child: Icon(
                      IconlyLight.arrowLeft2,
                      size: 24.sp,
                      color: AppMainColors.titanWithColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          userModel!.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 5.h),
        Text(
          userModel!.bio,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: AppMainColors.greyColor),
        ),
        SizedBox(height: 15.h),
        Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ).r,
          color: AppMainColors.greyColor.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5).r,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '${cubit.userPosts.length}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: AppMainColors.dividerColor),
                      ),
                      Text(
                        'Posts',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '10K',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: AppMainColors.dividerColor),
                      ),
                      Text(
                        'Followers',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      navigateTo(
                        context,
                        FriendsScreen(
                          cubit.friends,
                          myFriends: true,
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Text(
                          '${cubit.friends.length}',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: AppMainColors.dividerColor),
                        ),
                        Text(
                          'Friends',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ).r,
          child: Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: AppMainColors.blueColor,
                  ),
                  onPressed: () {
                    cubit.getStoryImage(context);
                  },
                  icon: Icon(
                    IconlyLight.plus,
                    size: 24.sp,
                    color: AppMainColors.titanWithColor,
                  ),
                  label: Text(
                    'Add story',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: AppMainColors.greyColor.withOpacity(0.4),
                  ),
                  onPressed: () {
                    navigateTo(context, EditProfileScreen());
                  },
                  icon: Icon(
                    IconlyLight.edit,
                    size: 24.sp,
                    color: AppMainColors.blueColor,
                  ),
                  label: Text(
                    'Edit profile',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        const MyDivider(),
      ],
    );
  }
}
