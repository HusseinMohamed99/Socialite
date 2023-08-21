import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociality/model/user_model.dart';
import 'package:sociality/pages/friend/friends_profile_screen.dart';
import 'package:sociality/shared/components/image_with_shimmer.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/styles/color.dart';

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
