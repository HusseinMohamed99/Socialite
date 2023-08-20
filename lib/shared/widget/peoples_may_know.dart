import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociality/model/user_model.dart';
import 'package:sociality/pages/friend/friends_profile_screen.dart';
import 'package:sociality/shared/components/image_with_shimmer.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/styles/color.dart';

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
