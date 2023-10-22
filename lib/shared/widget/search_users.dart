import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/pages/friend/friends_profile_screen.dart';
import 'package:socialite/pages/profile/user_profile_screen.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';

class SearchUsersItems extends StatelessWidget {
  const SearchUsersItems({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: InkWell(
        onTap: () {
          if (user.uId != uId) {
            SocialCubit.get(context).getFriendsProfile(user.uId);
            SocialCubit.get(context).getUserPosts(user.uId);

            navigateTo(
              context,
              FriendsProfileScreen(user.uId),
            );
          } else {
            SocialCubit.get(context).getUserPosts(uId);
            navigateTo(
              context,
              const UserProfileScreen(),
            );
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              child: ImageWithShimmer(
                imageUrl: user.image,
                width: 60,
                height: 60,
                radius: 30,
                boxFit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${SocialCubit.get(context).users.length - 1} ${AppString.mutualFriends}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            const Icon(
              IconlyBroken.user2,
              color: ColorManager.greyColor,
            ),
          ],
        ),
      ),
    );
  }
}
