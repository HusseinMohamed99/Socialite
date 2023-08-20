import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:sociality/Pages/chat/private_chat.dart';
import 'package:sociality/Pages/friend/friend_screen.dart';
import 'package:sociality/shared/components/indicator.dart';
import 'package:sociality/model/user_model.dart';
import 'package:sociality/pages/viewPhoto/image_view.dart';
import 'package:sociality/shared/components/my_divider.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/cubit/socialCubit/social_state.dart';
import 'package:sociality/shared/components/components.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sociality/shared/widget/build_post_item.dart';

class FriendsProfileScreen extends StatelessWidget {
  FriendsProfileScreen(this.userUID, {Key? key}) : super(key: key);
  final String? userUID;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var friendsModel = SocialCubit.get(context).friendsProfile;
        List<UserModel>? friends = SocialCubit.get(context).friends;
        SocialCubit cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: friendsModel == null,
          builder: (context) => Scaffold(
            body: Center(
              child: AdaptiveIndicator(
                os: getOs(),
              ),
            ),
          ),
          fallback: (context) => Scaffold(
            key: scaffoldKey,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15).r,
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 280.h,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                  ).r),
                                  width: double.infinity,
                                  height: 230.h,
                                  child: ImageViewScreen(
                                      image: friendsModel?.cover, body: ''),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  navigateTo(
                                    context,
                                    ImageViewScreen(
                                        image: friendsModel.image, body: ''),
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 75,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      friendsModel!.image,
                                    ),
                                    radius: 70.r,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 60.h,
                                left: 5.w,
                                child: IconButton(
                                  onPressed: () {
                                    pop(context);
                                  },
                                  icon: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    child: Icon(
                                      IconlyLight.arrowLeft2,
                                      size: 30.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        space(0, 5.h),
                        Text(
                          friendsModel.name,
                          style: GoogleFonts.roboto(
                            fontSize: 24.sp,
                            color: cubit.isDark ? Colors.blue : Colors.white,
                          ),
                        ),
                        space(0, 5.h),
                        Text(
                          friendsModel.bio,
                          style: GoogleFonts.roboto(
                            textStyle:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 16.sp,
                                      color: Colors.grey,
                                    ),
                          ),
                        ),
                        space(0, 15.h),
                        Card(
                          margin: const EdgeInsets.symmetric(horizontal: 10).r,
                          color: Colors.grey[100],
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      '${cubit.userPosts.length}',
                                      style: GoogleFonts.roboto(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              fontSize: 20.sp,
                                            ),
                                      ),
                                    ),
                                    Text(
                                      'Posts',
                                      style: GoogleFonts.roboto(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              fontSize: 20.sp,
                                              color: Colors.black,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      '10K',
                                      style: GoogleFonts.roboto(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              fontSize: 20.sp,
                                            ),
                                      ),
                                    ),
                                    Text(
                                      'Followers',
                                      style: GoogleFonts.roboto(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              fontSize: 20.sp,
                                              color: Colors.black,
                                            ),
                                      ),
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
                                        friends,
                                        myFriends: true,
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        '${friends.length}',
                                        style: GoogleFonts.roboto(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(fontSize: 20.sp),
                                        ),
                                      ),
                                      Text(
                                        'Friends',
                                        style: GoogleFonts.roboto(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                fontSize: 20.sp,
                                                color: Colors.black,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0).r,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            SocialCubit.get(context).isFriend ==
                                                    false
                                                ? MaterialStateProperty.all(
                                                    Colors.blueAccent)
                                                : MaterialStateProperty.all(
                                                    Colors.grey[300])),
                                    onPressed: () {
                                      if (SocialCubit.get(context).isFriend ==
                                          false) {
                                        SocialCubit.get(context)
                                            .sendFriendRequest(
                                                friendsUID: userUID,
                                                friendName: friendsModel.name,
                                                friendImage:
                                                    friendsModel.image);
                                        SocialCubit.get(context)
                                            .checkFriendRequest(userUID);
                                        SocialCubit.get(context)
                                            .sendInAppNotification(
                                                contentKey: 'friendRequest',
                                                contentId: friendsModel.uId,
                                                content:
                                                    'sent you a friend request, check it out!',
                                                receiverId: friendsModel.uId,
                                                receiverName:
                                                    friendsModel.name);
                                        SocialCubit.get(context)
                                            .sendFCMNotification(
                                                token: friendsModel.uId,
                                                senderName:
                                                    SocialCubit.get(context)
                                                        .userModel!
                                                        .name,
                                                messageText:
                                                    '${SocialCubit.get(context).userModel!.name}'
                                                    'sent you a friend request, check it out!');
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) => baseAlertDialog(
                                            context: context,
                                            title: 'You are already Friends',
                                            content:
                                                'Do you want to Unfriend ?',
                                            outlinedButtonText: 'Cancel',
                                            elevatedButtonText: 'Unfriend',
                                            elevatedButtonIcon:
                                                Icons.person_remove,
                                          ),
                                          barrierDismissible: true,
                                        );
                                      }
                                    },
                                    child: SocialCubit.get(context).isFriend ==
                                            false
                                        ? SocialCubit.get(context).request
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .person_add_alt_1_rounded,
                                                    color: Colors.white,
                                                    size: 24.sp,
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  const Text(
                                                    'requestSent',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    size: 24.sp,
                                                    Icons
                                                        .person_add_alt_1_rounded,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  const Text(
                                                    'addFriend',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.person,
                                                color: Colors.black,
                                                size: 24.sp,
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              const Text(
                                                'profileFriends',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          )),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0).r,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          SocialCubit.get(context).isFriend ==
                                                  false
                                              ? MaterialStateProperty.all(
                                                  Colors.grey[300])
                                              : MaterialStateProperty.all(
                                                  Colors.blueAccent,
                                                ),
                                    ),
                                    onPressed: () {
                                      navigateTo(
                                        context,
                                        PrivateChatScreen(
                                          userModel: friendsModel,
                                        ),
                                      );
                                    },
                                    child: SocialCubit.get(context).isFriend !=
                                            false
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                size: 24.sp,
                                                IconlyBroken.chat,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              const Text(
                                                'message',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                IconlyBroken.chat,
                                                color: Colors.black,
                                                size: 24.sp,
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              const Text(
                                                'message',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const MyDivider(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0)
                            .r,
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'Posts',
                        style: GoogleFonts.roboto(
                          fontSize: 24.sp,
                          color: cubit.isDark ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  ConditionalBuilder(
                      condition: cubit.userPosts.isNotEmpty,
                      builder: (context) => ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => BuildPostItem(
                              postModel: cubit.userPosts[index],
                              userModel: cubit.userModel!,
                              index: index,
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 10.h,
                            ),
                            itemCount: cubit.userPosts.length,
                          ),
                      fallback: (context) => Padding(
                            padding: const EdgeInsets.all(8.0).r,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 70.h,
                                ),
                                Icon(
                                  Icons.article_outlined,
                                  size: 70.sp,
                                  color: Colors.grey,
                                ),
                                Text(
                                  'No Posts',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
