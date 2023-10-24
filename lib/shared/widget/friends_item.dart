import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/pages/chat/private_chat.dart';
import 'package:socialite/pages/friend/friends_profile_screen.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';

class FriendsBuildItems extends StatelessWidget {
  const FriendsBuildItems({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        SocialCubit.get(context).getUserPosts(userModel.uId);
        SocialCubit.get(context).getFriendsProfile(userModel.uId);

        navigateTo(
          context,
          FriendsProfileScreen(userModel.uId),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              child: ImageWithShimmer(
                imageUrl: userModel.image,
                radius: 30,
                width: 60,
                height: 60,
                boxFit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                userModel.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: SocialCubit.get(context).isDark
                      ? ColorManager.blueColor
                      : ColorManager.primaryColor,
                ),
                onPressed: () => navigateTo(
                    context, PrivateChatScreen(userModel: userModel)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      IconlyBroken.chat,
                      color: ColorManager.whiteColor,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      AppString.message,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
