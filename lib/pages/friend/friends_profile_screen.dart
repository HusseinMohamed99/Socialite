import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/services.dart';
import 'package:socialite/Pages/friend/friend_screen.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/pages/chat/private_chat.dart';
import 'package:socialite/shared/components/components.dart';
import 'package:socialite/shared/components/indicator.dart';
import 'package:socialite/shared/components/my_divider.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/widget/build_post_item.dart';

class FriendsProfileScreen extends StatelessWidget {
  const FriendsProfileScreen(this.userUID, {Key? key}) : super(key: key);
  final String? userUID;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var friendsModel = SocialCubit.get(context).friendsProfile;
        SocialCubit cubit = SocialCubit.get(context);
        if (cubit.friendsProfile == null) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    IconlyBroken.infoSquare,
                    size: 100.sp,
                    color: ColorManager.greyColor,
                  ),
                  Text(
                    'No Posts yet',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const CircularProgressIndicator(),
                ],
              ),
            ),
          );
        } else {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            ),
            child: Scaffold(
              body: cubit.userPosts.isEmpty
                  ? ProfileInfo(friendsProfile: friendsModel!, cubit: cubit)
                  : ConditionalBuilder(
                      condition: cubit.userPosts.isNotEmpty,
                      builder: (context) => SingleChildScrollView(
                        child: Column(
                          children: [
                            ProfileInfo(
                                friendsProfile: friendsModel!, cubit: cubit),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10,
                                top: 10,
                              ).r,
                              child: Align(
                                alignment: AlignmentDirectional.topStart,
                                child: Text(
                                  'Posts',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                            ),
                            ListView.separated(
                              padding: const EdgeInsets.only(top: 10).r,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cubit.userPosts.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10.h),
                              itemBuilder: (context, index) => BuildPostItem(
                                postModel: cubit.userPosts[index],
                                userModel: cubit.userModel!,
                                index: index,
                              ),
                            ),
                          ],
                        ),
                      ),
                      fallback: (BuildContext context) => const Center(
                        child: AdaptiveIndicator(),
                      ),
                    ),
            ),
          );
        }
      },
    );
  }
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
    required this.friendsProfile,
    required this.cubit,
    this.userUID,
  });

  final UserModel friendsProfile;
  final SocialCubit cubit;
  final String? userUID;
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
                    friendsProfile.cover,
                  ),
                ),
              ),
              CircleAvatar(
                backgroundColor: ColorManager.dividerColor,
                radius: 75.r,
                child: CircleAvatar(
                  radius: 70.r,
                  child: imagePreview(friendsProfile.image, radius: 65.r),
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
          friendsProfile.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 5.h),
        Text(
          friendsProfile.bio,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: ColorManager.greyColor),
        ),
        SizedBox(height: 5.h),
        InkWell(
          onTap: () {
            urlLauncher(
              Uri.parse(friendsProfile.portfolio),
            );
          },
          child: Text(
            friendsProfile.portfolio,
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
                            .copyWith(color: ColorManager.dividerColor),
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
                              .copyWith(color: ColorManager.dividerColor),
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
                    backgroundColor: ColorManager.greyColor.withOpacity(0.4),
                  ),
                  onPressed: () {
                    if (SocialCubit.get(context).isFriend == false) {
                      SocialCubit.get(context).sendFriendRequest(
                          friendsUID: userUID!,
                          friendName: friendsProfile.name,
                          friendImage: friendsProfile.image);
                      SocialCubit.get(context).checkFriendRequest(userUID);
                      SocialCubit.get(context).sendInAppNotification(
                          contentKey: 'friendRequest',
                          contentId: friendsProfile.uId,
                          content: 'sent you a friend request, check it out!',
                          receiverId: friendsProfile.uId,
                          receiverName: friendsProfile.name);
                      SocialCubit.get(context).sendFCMNotification(
                          token: friendsProfile.uId,
                          senderName: SocialCubit.get(context).userModel!.name,
                          messageText:
                              '${SocialCubit.get(context).userModel!.name}'
                              'sent you a friend request, check it out!');
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => baseAlertDialog(
                          context: context,
                          title: 'You are already Friends',
                          content: 'Do you want to Unfriend ?',
                          outlinedButtonText: 'Cancel',
                          elevatedButtonText: 'Unfriend',
                          elevatedButtonIcon: Icons.person_remove,
                        ),
                        barrierDismissible: true,
                      );
                    }
                  },
                  label: SocialCubit.get(context).isFriend == false
                      ? SocialCubit.get(context).request
                          ? Text(
                              'Request Sent',
                              style: Theme.of(context).textTheme.titleLarge,
                            )
                          : Text(
                              'Add Friend',
                              style: Theme.of(context).textTheme.titleLarge,
                            )
                      : Text(
                          'Profile Friends',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                  icon: Icon(
                    IconlyBroken.user2,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: ColorManager.blueColor,
                  ),
                  onPressed: () {
                    navigateTo(
                      context,
                      PrivateChatScreen(
                        userModel: friendsProfile,
                      ),
                    );
                  },
                  label: const Text(
                    'message',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  icon: Icon(
                    IconlyBroken.chat,
                    color: Colors.black,
                    size: 24.sp,
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
