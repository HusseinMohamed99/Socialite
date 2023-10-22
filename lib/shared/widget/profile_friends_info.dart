import 'package:flutter/material.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:socialite/shared/components/my_divider.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';

class ProfileFriendsInfo extends StatelessWidget {
  const ProfileFriendsInfo({
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
