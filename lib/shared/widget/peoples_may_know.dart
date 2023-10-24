import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/pages/friend/friends_profile_screen.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';

class PeoplesMayKnow extends StatelessWidget {
  const PeoplesMayKnow(
      {super.key, required this.userModel, required this.socialCubit});
  final UserModel userModel;
  final SocialCubit socialCubit;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Container(
      width: screenWidth * .5,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: ColorManager.dividerColor,
          style: BorderStyle.solid,
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              socialCubit.getFriendsProfile(userModel.uId);
              socialCubit.getUserPosts(userModel.uId);
              navigateTo(context, FriendsProfileScreen(userModel.uId));
            },
            child: ImageWithShimmer(
              radius: 20,
              imageUrl: userModel.image,
              height: screenHeight * .2,
              width: double.infinity,
              boxFit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userModel.name,
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  userModel.bio,
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              socialCubit.sendFriendRequest(
                friendsUID: userModel.uId,
                friendName: userModel.name,
                friendImage: userModel.image,
              );
              socialCubit.sendInAppNotification(
                contentKey: AppString.friendRequest,
                contentId: userModel.uId,
                content: AppString.checkFriendRequest,
                receiverId: userModel.uId,
                receiverName: userModel.name,
              );
              socialCubit.sendFCMNotification(
                token: userModel.token,
                senderName: socialCubit.userModel!.name,
                messageText: '${socialCubit.userModel!.name}'
                    '${AppString.checkFriendRequest}',
              );
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: ColorManager.blueColor,
              ),
              child: socialCubit.isFriend == false
                  ? socialCubit.request
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              IconlyBroken.addUser,
                              color: ColorManager.titanWithColor,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              AppString.sentRequest,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              IconlyBroken.addUser,
                              color: ColorManager.titanWithColor,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              AppString.addFriend,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          IconlyBroken.user2,
                          color: ColorManager.titanWithColor,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          AppString.profile,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
