import 'package:socialite/model/user_model.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/components/my_divider.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/shared/utils/color_manager.dart';

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
              elevation: 1,
              leading: IconButton(
                onPressed: () {
                  pop(context);
                },
                icon: Icon(
                  IconlyBroken.arrowLeft2,
                  size: 30.sp,
                  color: cubit.isDark
                      ? ColorManager.blackColor
                      : ColorManager.titanWithColor,
                ),
              ),
              titleSpacing: 1,
              title: Text(
                'Friends',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: friends!.isEmpty
                ? Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          IconlyBroken.infoSquare,
                          color: ColorManager.greyColor,
                          size: 60.sp,
                        ),
                        Text(
                          'No Friends yet',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => FriendsBuilderItems(
                      friendsModel: friends[index],
                      myFriend: myFriends ?? false,
                      cubit: cubit,
                    ),
                    separatorBuilder: (context, index) => const MyDivider(),
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
      padding: const EdgeInsets.all(15).r,
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            child: ImageWithShimmer(
              imageUrl: friendsModel.image,
              width: 50.w,
              height: 50.h,
              radius: 10.r,
              boxFit: BoxFit.fill,
            ),
          ),
          SizedBox(width: 10.w),
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
                if (value == 'Unfriend') {
                  SocialCubit.get(context).unFriend(friendsModel.uId);
                }
              },
              child: Icon(
                IconlyBroken.moreSquare,
                color: cubit.isDark
                    ? ColorManager.blackColor
                    : ColorManager.titanWithColor,
                size: 24.sp,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  height: 20.h,
                  value: 'Unfriend',
                  child: Row(
                    children: [
                      Icon(
                        IconlyBroken.delete,
                        color: cubit.isDark
                            ? ColorManager.titanWithColor
                            : ColorManager.blackColor,
                        size: 24.sp,
                      ),
                      SizedBox(width: 15.w),
                      Text(
                        'Unfriend',
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
