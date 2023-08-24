import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:sociality/model/notifications_model.dart';
import 'package:sociality/pages/friend/friends_profile_screen.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/cubit/socialCubit/social_state.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var modalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getInAppNotification();
        var cubit = SocialCubit.get(context);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            List notifications = SocialCubit.get(context).notifications;
            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                centerTitle: false,
                elevation: 1,
                leading: IconButton(
                  icon: Icon(
                    IconlyBroken.arrowLeft2,
                    color:
                        cubit.isDark ? const Color(0xff404258) : Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  'Notifications',
                  style: GoogleFonts.libreBaskerville(
                    color: SocialCubit.get(context).isDark
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConditionalBuilder(
                      condition: notifications.isNotEmpty,
                      builder: (context) => Expanded(
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  notificationsBuilder(
                                      context, notifications[index]),
                              separatorBuilder: (context, index) => space(0, 0),
                              itemCount: notifications.length,
                            ),
                          ),
                      fallback: (context) => Expanded(
                            child: Center(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height - 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      IconlyLight.notification,
                                      color: Colors.grey,
                                      size: 60,
                                    ),
                                    space(0, 15),
                                    Text(
                                      'No Notifications',
                                      style: TextStyle(
                                          color: cubit.isDark
                                              ? Colors.red
                                              : Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget notificationsBuilder(context, NotificationModel notifications) {
    SocialCubit cubit = SocialCubit.get(context);
    return InkWell(
      onTap: () {
        if (notifications.contentKey == 'friendRequestAccepted') {
          SocialCubit.get(context)
              .readNotification(notifications.notificationId);
          navigateTo(context, FriendsProfileScreen(notifications.contentId));
        } else if (notifications.contentKey == 'likePost' ||
            notifications.contentKey == 'commentPost') {
          SocialCubit.get(context)
              .readNotification(notifications.notificationId);
        } else if (notifications.contentKey == 'friendRequest') {
          SocialCubit.get(context)
              .readNotification(notifications.notificationId);
        }
      },
      child: Container(
        color: cubit.isDark ? Colors.white : const Color(0xff404258),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage('${notifications.senderImage}'),
                    radius: 34,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.blueAccent.shade200,
                    radius: 15,
                    child: Icon(SocialCubit.get(context)
                        .notificationContentIcon(notifications.contentKey)),
                  ),
                ],
              ),
              space(10, 0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${notifications.senderName} ',
                        style: TextStyle(
                            color: cubit.isDark ? Colors.black : Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold)),
                    Text(
                        SocialCubit.get(context)
                            .notificationContent(notifications.contentKey),
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 15)),
                    Text(
                      getDate(notifications.dateTime),
                      style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    scaffoldKey.currentState!.showBodyScrim(true, 0.5);
                    scaffoldKey.currentState!
                        .showBottomSheet(
                          (context) => Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: const OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15)),
                                borderSide: BorderSide.none),
                            elevation: 15,
                            color: SocialCubit.get(context)
                                .backgroundColor
                                .withOpacity(1),
                            margin: EdgeInsets.zero,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.drag_handle),
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        '${notifications.senderImage}'),
                                    radius: 25,
                                  ),
                                  space(0, 10),
                                  Text(
                                    '${notifications.senderName} ${SocialCubit.get(context).notificationContent(notifications.contentKey)}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                  space(0, 15),
                                  InkWell(
                                    onTap: () {
                                      SocialCubit.get(context)
                                          .deleteNotification(
                                              notifications.notificationId);
                                    },
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          child: Icon(
                                              Icons.delete_outline_outlined),
                                        ),
                                        space(15, 0),
                                        const Text(
                                          'Remove this notification',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                  space(0, 15),
                                ],
                              ),
                            ),
                          ),
                          shape: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15)),
                              borderSide: BorderSide.none),
                        )
                        .closed
                        .then((value) {
                      scaffoldKey.currentState!.showBodyScrim(false, 1);
                    });
                  },
                  icon: const Icon(Icons.more_horiz_outlined))
            ],
          ),
        ),
      ),
    );
  }
}
