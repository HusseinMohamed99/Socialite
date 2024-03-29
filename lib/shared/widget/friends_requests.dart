import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/pages/friend/friends_profile_screen.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';

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
              navigateTo(
                context,
                FriendsProfileScreen(userModel.uId),
              );
              if (kDebugMode) {}
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
                          backgroundColor: ColorManager.blueColor,
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
                            contentKey: AppString.requestAccepted,
                            contentId: SocialCubit.get(context).userModel!.uId,
                            content: AppString.requestAcceptedContent,
                            receiverId: userModel.uId,
                            receiverName: userModel.name,
                          );
                          SocialCubit.get(context).sendFCMNotification(
                            token: userModel.uId,
                            senderName:
                                SocialCubit.get(context).userModel!.name,
                            messageText:
                                '${SocialCubit.get(context).userModel!.name}'
                                '${AppString.requestAcceptedContent}',
                          );
                        },
                        child: Text(
                          AppString.confirm,
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
                          AppString.delete,
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
