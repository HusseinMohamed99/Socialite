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
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';

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
                backgroundColor: ColorManager.dividerColor,
                radius: 75.r,
                child: CircleAvatar(
                  radius: 70.r,
                  child: imageWithShimmer(userModel!.image, radius: 65.r),
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
                    backgroundColor: ColorManager.greyDarkColor,
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
              .copyWith(color: ColorManager.greyColor),
        ),
        SizedBox(height: 5.h),
        InkWell(
          onTap: () {
            urlLauncher(
              Uri.parse(userModel!.portfolio),
            );
          },
          child: Text(
            userModel!.portfolio,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: ColorManager.blueColor),
          ),
        ),
        SizedBox(height: 15.h),
        Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ).r,
          color: ColorManager.greyColor.withOpacity(0.1),
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
                            .copyWith(color: ColorManager.dividerColor),
                      ),
                      Text(
                        AppString.post,
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
                            .copyWith(color: ColorManager.dividerColor),
                      ),
                      Text(
                        AppString.followers,
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
                              .copyWith(color: ColorManager.dividerColor),
                        ),
                        Text(
                          AppString.friends,
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
                    backgroundColor: ColorManager.blueColor,
                  ),
                  onPressed: () {
                    cubit.getStoryImage(context);
                  },
                  icon: Icon(
                    IconlyLight.plus,
                    size: 24.sp,
                    color: ColorManager.titanWithColor,
                  ),
                  label: Text(
                    AppString.addStory,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: ColorManager.greyColor.withOpacity(0.4),
                  ),
                  onPressed: () {
                    navigateTo(context, const EditProfileScreen());
                  },
                  icon: Icon(
                    IconlyBroken.edit,
                    size: 24.sp,
                    color: ColorManager.blueColor,
                  ),
                  label: Text(
                    AppString.editProfile,
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
