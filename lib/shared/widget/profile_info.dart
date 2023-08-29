import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/pages/friend/friend_screen.dart';
import 'package:socialite/pages/profile/edit_profile_screen.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:socialite/shared/components/my_divider.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/styles/color.dart';

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
                  height: 200.h,
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
                      IconlyBroken.arrowLeft2,
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
        SizedBox(height: 5.h),
        Text(
          userModel!.portfolio,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: AppMainColors.blueColor),
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
                        '${cubit.friends.length}',
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
                    navigateTo(context, const EditProfileScreen());
                  },
                  icon: Icon(
                    IconlyBroken.edit,
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
