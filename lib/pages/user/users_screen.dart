import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociality/model/user_model.dart';
import 'package:sociality/pages/chat/private_chat.dart';
import 'package:sociality/pages/friend/friends_profile_screen.dart';
import 'package:sociality/shared/components/image_with_shimmer.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/cubit/socialCubit/social_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:sociality/shared/styles/color.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getFriendRequest();
        SocialCubit.get(context).getAllUsers();
        SocialCubit.get(context)
            .getFriends(SocialCubit.get(context).userModel!.uId);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            List<UserModel> peopleYouMayKnow =
                SocialCubit.get(context).users.cast<UserModel>();
            List<UserModel> friendRequests =
                SocialCubit.get(context).friendRequests.cast<UserModel>();
            List<UserModel> friends =
                SocialCubit.get(context).friends.cast<UserModel>();
            return SocialCubit.get(context).users.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          IconlyLight.chat,
                          size: 70.sp,
                          color: AppMainColors.greyColor,
                        ),
                        Text(
                          'No Users Yet,\nPlease Add\nSome Friends',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: onRefresh,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15).r,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15.h),
                            Text(
                              'Friend Request',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            ConditionalBuilder(
                                condition: friendRequests.isNotEmpty,
                                builder: (context) => ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          FriendRequestItems(
                                              userModel: friendRequests[index]),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(width: 10.w),
                                      itemCount: friendRequests.length,
                                    ),
                                fallback: (context) => Container(
                                      padding: const EdgeInsets.only(
                                        top: 15,
                                        bottom: 5,
                                      ).r,
                                      alignment: AlignmentDirectional.center,
                                      child: Text(
                                        'No Friend Request',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                    )),
                            SizedBox(height: 10.h),
                            Text(
                              'People May Know',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              height: 250.h,
                              width: 200.w,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10).r,
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return PeoplesMayKnow(
                                      userModel: peopleYouMayKnow[index]);
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 10.w),
                                itemCount: peopleYouMayKnow.length,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              'Friends',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(height: 10.h),
                            ConditionalBuilder(
                              condition: friends.isNotEmpty,
                              builder: (context) => ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    FriendBuildItems(userModel: friends[index]),
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 10.h),
                                itemCount: friends.length,
                              ),
                              fallback: (context) => Container(
                                padding: const EdgeInsets.only(
                                  top: 15,
                                  bottom: 5,
                                ).r,
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  'No Friends',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
        );
      },
    );
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    SocialCubit.get(BuildContext).getUserData();
    SocialCubit.get(BuildContext).getFriendRequest();
    SocialCubit.get(BuildContext).getAllUsers();
    SocialCubit.get(BuildContext)
        .getFriends(SocialCubit.get(BuildContext).userModel!.uId);
  }
}

class FriendBuildItems extends StatelessWidget {
  const FriendBuildItems({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).build(context);
        navigateTo(context, FriendsProfileScreen(userModel.uId));
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            child: ImageWithShimmer(
              imageUrl: userModel.image,
              radius: 25.r,
              width: 50.w,
              height: 50.h,
              boxFit: BoxFit.fill,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              userModel.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8).r,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: SocialCubit.get(context).isDark
                    ? AppMainColors.blueColor
                    : AppMainColors.whiteColor,
              ),
              onPressed: () =>
                  navigateTo(context, PrivateChatScreen(userModel: userModel)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    IconlyBroken.chat,
                    size: 24.sp,
                    color: SocialCubit.get(context).isDark
                        ? AppMainColors.whiteColor
                        : AppMainColors.blackColor,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    'Message',
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

class PeoplesMayKnow extends StatelessWidget {
  const PeoplesMayKnow({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 200.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10).r,
          border: Border.all(
              color: AppMainColors.greenColor, style: BorderStyle.solid)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                SocialCubit.get(context).getFriends(userModel.uId);
                SocialCubit.get(context).checkFriends(userModel.uId);
                SocialCubit.get(context).checkFriendRequest(userModel.uId);
                navigateTo(context, FriendsProfileScreen(userModel.uId));
              },
              child: ImageWithShimmer(
                imageUrl: userModel.image,
                height: 150.h,
                width: double.infinity,
                boxFit: BoxFit.fill,
                radius: 10.r,
              )),
          SizedBox(height: 10.h),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userModel.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 5.h),
                Text(
                  userModel.bio,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppMainColors.blueColor,
              ),
              onPressed: () {
                SocialCubit.get(context).sendFriendRequest(
                  friendsUID: userModel.uId,
                  friendName: userModel.name,
                  friendImage: userModel.image,
                );
                SocialCubit.get(context).sendInAppNotification(
                  contentKey: 'friendRequest',
                  contentId: userModel.uId,
                  content: 'sent you a friend request, check it out!',
                  receiverId: userModel.uId,
                  receiverName: userModel.name,
                );
                SocialCubit.get(context).sendFCMNotification(
                    token: userModel.uId,
                    senderName: SocialCubit.get(context).userModel!.name,
                    messageText: '${SocialCubit.get(context).userModel!.name}'
                        'sent you a friend request, check it out!');
              },
              child: SocialCubit.get(context).isFriend == false
                  ? SocialCubit.get(context).request
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_add_alt_1_rounded,
                              color: AppMainColors.titanWithColor,
                              size: 24.sp,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              'Request Sent',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_add_alt_1_rounded,
                              color: AppMainColors.titanWithColor,
                              size: 24.sp,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              'Add Friend',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: AppMainColors.titanWithColor,
                          size: 24.sp,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          'Profile Friends',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }
}

class FriendRequestItems extends StatelessWidget {
  const FriendRequestItems({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10).r,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              navigateTo(context, FriendsProfileScreen(userModel.uId));
              if (kDebugMode) {
                print(userModel.uId);
              }
            },
            child: CircleAvatar(
              radius: 30.r,
              child: ImageWithShimmer(
                imageUrl: userModel.image,
                height: 60.h,
                width: 60.w,
                radius: 25.r,
                boxFit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userModel.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  userModel.bio,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppMainColors.blueColor,
                        ),
                        onPressed: () {
                          SocialCubit.get(context).addFriend(
                            friendsUID: userModel.uId,
                            friendName: userModel.name,
                            friendImage: userModel.image,
                            friendCover: userModel.cover,
                            friendBio: userModel.bio,
                            friendEmail: userModel.email,
                            friendPhone: userModel.phone,
                          );
                          SocialCubit.get(context)
                              .deleteFriendRequest(userModel.uId);
                          SocialCubit.get(context).sendInAppNotification(
                            contentKey: 'friendRequestAccepted',
                            contentId: SocialCubit.get(context).userModel!.uId,
                            content:
                                'accepted your friend request, you are now friends checkout his profile',
                            receiverId: userModel.uId,
                            receiverName: userModel.name,
                          );
                          SocialCubit.get(context).sendFCMNotification(
                              token: userModel.uId,
                              senderName:
                                  SocialCubit.get(context).userModel!.name,
                              messageText:
                                  '${SocialCubit.get(context).userModel!.name}'
                                  'accepted your friend request, you are now friends checkout his profile');
                        },
                        child: Text(
                          'Confirm',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          SocialCubit.get(context)
                              .deleteFriendRequest(userModel.uId);
                        },
                        child: Text(
                          'Delete',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
