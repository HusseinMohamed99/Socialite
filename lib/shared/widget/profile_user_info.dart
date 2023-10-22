import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/pages/friend/friend_screen.dart';
import 'package:socialite/pages/profile/edit_profile_screen.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:socialite/shared/components/my_divider.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';

class ProfileUserInfo extends StatelessWidget {
  const ProfileUserInfo({
    super.key,
    required this.userModel,
    required this.cubit,
  });

  final UserModel? userModel;
  final SocialCubit cubit;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double screenHeight = MediaQuery.sizeOf(context).height;
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              width: screenWidth,
              height: screenHeight * .3,
              child: imagePreview(
                userModel!.cover,
                height: screenHeight * .3,
              ),
            ),
            SizedBox(height: screenHeight * .07),
            Text(
              userModel!.name,
              style: Theme.of(context).textTheme.titleLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              userModel!.bio,
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
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
            const SizedBox(height: 15),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
              color: ColorManager.scaffoldBackgroundDarkColor.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p6),
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
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p12,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: ColorManager.primaryColor,
                      ),
                      onPressed: () {
                        cubit.getStoryImage(context);
                      },
                      icon: const Icon(
                        IconlyBroken.plus,
                        color: ColorManager.titanWithColor,
                      ),
                      label: Text(
                        AppString.addStory,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: ColorManager.whiteColor,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            ColorManager.greyColor.withOpacity(0.4),
                      ),
                      onPressed: () {
                        navigateTo(context, const EditProfileScreen());
                      },
                      icon: const Icon(
                        IconlyBroken.edit,
                        color: ColorManager.blueColor,
                      ),
                      label: Text(
                        AppString.editProfile,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: ColorManager.whiteColor,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const MyDivider(vertical: AppPadding.p16),
          ],
        ),
        Positioned(
          top: screenHeight * .2,
          left: screenWidth * .3,
          child: CircleAvatar(
            backgroundColor: ColorManager.dividerColor,
            radius: 75,
            child: CircleAvatar(
              radius: 70,
              child: imageWithShimmer(userModel!.image, radius: 65),
            ),
          ),
        ),
      ],
    );
  }
}
