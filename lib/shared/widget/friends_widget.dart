import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';

class FriendsBuilderItems extends StatelessWidget {
  const FriendsBuilderItems({
    super.key,
    required this.cubit,
    required this.friendsModel,
    required this.myFriend,
  });
  final SocialCubit cubit;
  final UserModel friendsModel;
  final bool myFriend;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            child: ImageWithShimmer(
              imageUrl: friendsModel.image,
              width: 50,
              height: 50,
              radius: 10,
              boxFit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            friendsModel.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          if (myFriend)
            PopupMenuButton(
              color: cubit.isDark
                  ? ColorManager.blackColor
                  : ColorManager.titanWithColor,
              onSelected: (value) {
                if (value == AppString.unFriends) {
                  SocialCubit.get(context).unFriend(friendsModel.uId);
                }
              },
              child: Icon(
                IconlyBroken.moreSquare,
                color: cubit.isDark
                    ? ColorManager.blackColor
                    : ColorManager.titanWithColor,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  height: 20,
                  value: AppString.unFriends,
                  child: Row(
                    children: [
                      Icon(
                        IconlyBroken.delete,
                        color: cubit.isDark
                            ? ColorManager.titanWithColor
                            : ColorManager.blackColor,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        AppString.unFriends,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: cubit.isDark
                                  ? ColorManager.titanWithColor
                                  : ColorManager.blackColor,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
