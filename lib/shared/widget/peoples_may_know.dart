import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/pages/friend/friends_profile_screen.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';

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
            color: ColorManager.greenColor, style: BorderStyle.solid),
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
                contentKey: AppString.friendRequest,
                contentId: userModel.uId,
                content: AppString.checkFriendRequest,
                receiverId: userModel.uId,
                receiverName: userModel.name,
              );
              SocialCubit.get(context).sendFCMNotification(
                token: userModel.token,
                senderName: SocialCubit.get(context).userModel!.name,
                messageText: '${SocialCubit.get(context).userModel!.name}'
                    '${AppString.checkFriendRequest}',
              );
            },
            child: Container(
              color: ColorManager.blueColor,
              child: SocialCubit.get(context).isFriend == false
                  ? SocialCubit.get(context).request
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_add_alt_1_rounded,
                              color: ColorManager.titanWithColor,
                              size: 24.sp,
                            ),
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
                            Icon(
                              Icons.person_add_alt_1_rounded,
                              color: ColorManager.titanWithColor,
                              size: 24.sp,
                            ),
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
                        Icon(
                          Icons.person,
                          color: ColorManager.titanWithColor,
                          size: 24.sp,
                        ),
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
