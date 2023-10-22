import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialite/image_assets.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/components/my_divider.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';

class FriendsScreen extends StatelessWidget {
  final bool? myFriends;
  final List<UserModel>? friends;

  const FriendsScreen(this.friends, {Key? key, this.myFriends = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List<UserModel>? friends = this.friends;
          SocialCubit cubit = SocialCubit.get(context);
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                AppString.friends,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(letterSpacing: 10),
              ),
            ),
            body: friends!.isEmpty
                ? Center(
                    child: SvgPicture.asset(Assets.imagesUndrawNotFound),
                  )
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => FriendsBuilderItems(
                      friendsModel: friends[index],
                      myFriend: myFriends ?? false,
                      cubit: cubit,
                    ),
                    separatorBuilder: (context, index) => const MyDivider(
                      vertical: AppPadding.p12,
                    ),
                    itemCount: friends.length,
                  ),
          );
        },
      );
    });
  }
}

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
