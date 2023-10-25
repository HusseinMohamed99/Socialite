import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialite/model/notifications_model.dart';
import 'package:socialite/pages/friend/friends_profile_screen.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';

class NotificationsBuilder extends StatelessWidget {
  const NotificationsBuilder({
    super.key,
    required this.cubit,
    required this.notifications,
  });

  final SocialCubit cubit;
  final NotificationModel notifications;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        notificationMethod(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: ImageWithShimmer(
                    imageUrl: '${notifications.senderImage}',
                    radius: 30,
                    width: 70,
                    height: 70,
                  ),
                ),
                CircleAvatar(
                  radius: 12,
                  backgroundColor: ColorManager.blueColor,
                  child: Icon(
                    size: 20,
                    color: ColorManager.titanWithColor,
                    cubit.notificationContentIcon(notifications.contentKey),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${notifications.senderName}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    SocialCubit.get(context)
                        .notificationContent(notifications.contentKey),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: ColorManager.blueColor),
                  ),
                  Text(
                    getDate(notifications.dateTime),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                showBottomSheet(context);
              },
              icon: Icon(
                Icons.more_horiz_outlined,
                color: cubit.isDark
                    ? ColorManager.greyColor
                    : ColorManager.titanWithColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void notificationMethod(BuildContext context) {
    if (notifications.contentKey == AppString.requestAccepted) {
      SocialCubit.get(context).readNotification(notifications.notificationId);
      navigateTo(context, FriendsProfileScreen(notifications.contentId!));
    } else if (notifications.contentKey == AppString.likePost ||
        notifications.contentKey == AppString.commentPost) {
      SocialCubit.get(context).readNotification(notifications.notificationId);
    } else if (notifications.contentKey == AppString.friendRequest) {
      SocialCubit.get(context).readNotification(notifications.notificationId);
    } else if (notifications.contentKey == AppString.post) {
      SocialCubit.get(context).readNotification(notifications.notificationId);
    }
  }

  Future<dynamic> showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (buildContext) {
        SocialCubit cubit = SocialCubit.get(context);
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.drag_handle,
                  color: cubit.isDark
                      ? ColorManager.greyColor
                      : ColorManager.titanWithColor,
                ),
                CircleAvatar(
                  radius: 25,
                  child: ImageWithShimmer(
                    imageUrl: '${notifications.senderImage}',
                    radius: 30,
                    width: 70,
                    height: 70,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${notifications.senderName}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      cubit.notificationContent(notifications.contentKey),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: ColorManager.dividerColor),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    SocialCubit.get(context)
                        .deleteNotification(notifications.notificationId);
                  },
                  child: Row(
                    children: [
                      const CircleAvatar(
                        child: Icon(
                          IconlyBroken.delete,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        AppString.removeNotifications,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: ColorManager.redColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }
}
