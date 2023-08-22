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
      width: 120.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10).r,
        border: Border.all(
            color: AppMainColors.greenColor, style: BorderStyle.solid),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              navigateTo(context, FriendsProfileScreen(userModel.uId));
              SocialCubit.get(context).getUserPosts(userModel.uId);
            },
            child: ImageWithShimmer(
              imageUrl: userModel.image,
              height: 100.h,
              width: 120.w,
              boxFit: BoxFit.fitWidth,
            ),
          ),
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
          const Spacer(),
          InkWell(
            onTap: () {
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
                  token: userModel.token,
                  senderName: SocialCubit.get(context).userModel!.name,
                  messageText: '${SocialCubit.get(context).userModel!.name}'
                      'sent you a friend request, check it out!');
            },
            child: Container(
              color: AppMainColors.blueColor,
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
                            Text(
                              'Request Sent',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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
                            Text(
                              'Add Friend',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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
                        Text(
                          'Profile',
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
