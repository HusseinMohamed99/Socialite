import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/model/notifications_model.dart';
import 'package:socialite/pages/friend/friends_profile_screen.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/components/my_divider.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:socialite/shared/utils/color_manager.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit cubit = SocialCubit.get(context);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: false,
                elevation: 1,
                leading: IconButton(
                  icon: Icon(
                    IconlyBroken.arrowLeft2,
                    size: 30.sp,
                    color: cubit.isDark
                        ? ColorManager.blackColor
                        : ColorManager.titanWithColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  'Notifications',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              body: ConditionalBuilder(
                condition: cubit.notifications.isNotEmpty,
                builder: (context) => ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => NotificationsBuilder(
                    notifications: cubit.notifications[index],
                    cubit: cubit,
                  ),
                  separatorBuilder: (context, index) => const MyDivider(),
                  itemCount: cubit.notifications.length,
                ),
                fallback: (context) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        IconlyLight.notification,
                        color: ColorManager.greyColor,
                        size: 60.sp,
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        'No Notifications',
                        style: Theme.of(context).textTheme.titleLarge,
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
}

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
        if (notifications.contentKey == 'friend Request Accepted') {
          SocialCubit.get(context)
              .readNotification(notifications.notificationId);
          navigateTo(context, FriendsProfileScreen(notifications.contentId));
        } else if (notifications.contentKey == 'like Post' ||
            notifications.contentKey == 'comment Post') {
          SocialCubit.get(context)
              .readNotification(notifications.notificationId);
        } else if (notifications.contentKey == 'friend Request') {
          SocialCubit.get(context)
              .readNotification(notifications.notificationId);
        } else if (notifications.contentKey == 'post') {
          SocialCubit.get(context)
              .readNotification(notifications.notificationId);
        }
      },
      child: Container(
        color:
            cubit.isDark ? ColorManager.titanWithColor : ColorManager.greyColor,
        child: Padding(
          padding: const EdgeInsets.all(10).r,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    child: ImageWithShimmer(
                      imageUrl: '${notifications.senderImage}',
                      radius: 30.r,
                      width: 70.w,
                      height: 70.h,
                    ),
                  ),
                  CircleAvatar(
                    radius: 12.r,
                    backgroundColor: ColorManager.blueColor,
                    child: Icon(
                      size: 20.sp,
                      color: ColorManager.titanWithColor,
                      cubit.notificationContentIcon(notifications.contentKey),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${notifications.senderName} ',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      SocialCubit.get(context)
                          .notificationContent(notifications.contentKey),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: ColorManager.dividerColor),
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
                  size: 24.sp,
                  color: cubit.isDark
                      ? ColorManager.greyColor
                      : ColorManager.titanWithColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (buildContext) {
        SocialCubit cubit = SocialCubit.get(context);
        return Container(
          color: cubit.isDark
              ? ColorManager.titanWithColor
              : ColorManager.greyColor,
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15).r,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.drag_handle,
                  size: 24.sp,
                  color: cubit.isDark
                      ? ColorManager.greyColor
                      : ColorManager.titanWithColor,
                ),
                CircleAvatar(
                  radius: 25,
                  child: ImageWithShimmer(
                    imageUrl: '${notifications.senderImage}',
                    radius: 30.r,
                    width: 70.w,
                    height: 70.h,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${notifications.senderName}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(width: 5.h),
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
                SizedBox(height: 15.h),
                InkWell(
                  onTap: () {
                    SocialCubit.get(context)
                        .deleteNotification(notifications.notificationId);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: Icon(
                          Icons.delete_outline_outlined,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Text(
                        'Remove this notification',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: ColorManager.redColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
