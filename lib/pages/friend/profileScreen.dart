

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:f_app/Pages/chat/private_chat.dart';
import 'package:f_app/Pages/friend/friendScreen.dart';
import 'package:f_app/adaptive/indicator.dart';
import 'package:f_app/model/post_model.dart';
import 'package:f_app/model/user_model.dart';
import 'package:f_app/pages/veiwPhoto/image_view.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialState.dart';
import 'package:f_app/shared/components/components.dart';
import 'package:f_app/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendsProfileScreen extends StatelessWidget {
  String? userUID;
  FriendsProfileScreen(this.userUID, {Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SocialCubit.get(context).getMyPosts(userUID);

    SocialCubit.get(context).getFriends(userUID);
    SocialCubit.get(context).checkFriends(userUID);
    SocialCubit.get(context).checkFriendRequest(userUID);
    UserModel? friendsModel = SocialCubit.get(context).friendsProfile;
    List<PostModel>? posts = SocialCubit.get(context).userPosts;
    List<UserModel>? friends = SocialCubit.get(context).friends;
    var cubit = SocialCubit.get(context);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state)
        {

        },
        builder: (context, state) {

          SocialCubit.get(context).getFriendsProfile(userUID);
          return ConditionalBuilder(
            condition: friendsModel == null,
            builder: (context) =>  Center(
              child: AdaptiveIndicator(os: getOs()),
            ),
            fallback: (context) => Scaffold(
              key: scaffoldKey,

              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 280,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                Align(
                                  alignment:
                                      AlignmentDirectional.topCenter,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        borderRadius:
                                            BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          topRight: Radius.circular(8.0),
                                        )),
                                    width: double.infinity,
                                    height: 230,
                                    child: ImageViewScreen(image: friendsModel!.cover, body: ''),
                                  ),
                                ),

                                InkWell(
                                  onTap: ()
                                  {
                                    navigateTo(context, ImageViewScreen(image: friendsModel.image, body: ''));

                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 75,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        '${friendsModel.image}',
                                      ),
                                      radius: 70,
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: 60,
                                  left: 5,
                                  child: IconButton(
                                    onPressed: () {
                                      pop(context);
                                    },
                                    icon: const CircleAvatar(
                                      backgroundColor: Colors.black,
                                      child: Icon(
                                        IconlyLight.arrowLeft2,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          space(0, 5),
                          Text(
                            '${friendsModel.name}',
                            style: GoogleFonts.roboto(
                              fontSize: 24,
                              color: cubit.isLight
                                  ? Colors.blue
                                  : Colors.white,
                            ),
                          ),
                          space(0, 5),
                          Text(
                            '${friendsModel.bio}',
                            style: GoogleFonts.roboto(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                            ),
                          ),
                          space(0, 15),
                          Card(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.grey[100],
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        '${posts.length}',
                                        style: GoogleFonts.roboto(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(fontSize: 20),
                                        ),
                                      ),
                                      Text(
                                        'Posts',
                                        style: GoogleFonts.roboto(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  fontSize: 20,
                                                  color: Colors.black),
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
                                              .caption!
                                              .copyWith(fontSize: 20),
                                        ),
                                      ),
                                      Text(
                                        'Followers',
                                        style: GoogleFonts.roboto(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: ()
                                    {
                                      navigateTo(context, FriendsScreen(friends,myFreinds: true,));

                                    },
                                    child: Column(
                                      children: [
                                        Text(
                                          '${friends.length}',
                                          style: GoogleFonts.roboto(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(fontSize: 20),
                                          ),
                                        ),
                                        Text(
                                          'Friends',
                                          style: GoogleFonts.roboto(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                    fontSize: 20,
                                                    color: Colors.black),
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor: SocialCubit.get(
                                                          context)
                                                      .isFriend ==
                                                  false
                                              ? MaterialStateProperty.all(
                                                  Colors.blueAccent)
                                              : MaterialStateProperty.all(
                                                  Colors.grey[300])),
                                      onPressed: () {
                                        if (SocialCubit.get(context)
                                                .isFriend ==
                                            false) {
                                          SocialCubit.get(context)
                                              .sendFriendRequest(
                                                  friendsUID: userUID,
                                                  friendName:
                                                      friendsModel.name,
                                                  friendImage:
                                                      friendsModel.image);
                                          SocialCubit.get(context)
                                              .checkFriendRequest(userUID);
                                          SocialCubit.get(context).sendInAppNotification(
                                              contentKey: 'friendRequest',
                                              contentId: friendsModel.uId,
                                              content: 'sent you a friend request, check it out!',
                                              receiverId: friendsModel.uId,
                                              receiverName: friendsModel.name
                                          );
                                          SocialCubit.get(context).sendFCMNotification(
                                              token: friendsModel.token!,
                                              senderName: SocialCubit.get(context).userModel!.name!,
                                              messageText: '${SocialCubit.get(context).userModel!.name}' 'sent you a friend request, check it out!'
                                          );
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                baseAlertDialog(
                                              context: context,
                                              title:
                                                  'You are already Friends',
                                              content:
                                                  'Do you want to Unfriend ?',
                                              outlinedButtonText: 'Cancel',
                                              elevatedButtonText:
                                                  'Unfriend',
                                              elevatedButtonIcon:
                                                  Icons.person_remove,
                                            ),
                                            barrierDismissible: true,
                                          );
                                        }
                                      },
                                      child: SocialCubit.get(context)
                                                  .isFriend ==
                                              false
                                          ? SocialCubit.get(context).request
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  children: const [
                                                    Icon(
                                                      Icons
                                                          .person_add_alt_1_rounded,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text('requestSent',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white)),
                                                  ],
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  children: const [
                                                    Icon(
                                                      Icons
                                                          .person_add_alt_1_rounded,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text('addFriend',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white)),
                                                  ],
                                                )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  Icons.person,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'profileFriends',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            )),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor: SocialCubit.get(
                                                          context)
                                                      .isFriend ==
                                                  false
                                              ? MaterialStateProperty.all(
                                                  Colors.grey[300])
                                              : MaterialStateProperty.all(
                                                  Colors.blueAccent)),
                                      onPressed: () {
                                        navigateTo(context, PrivateChatScreen(userModel: friendsModel,));
                                      },
                                      child: SocialCubit.get(context)
                                                  .isFriend !=
                                              false
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  IconlyBroken.chat,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text('message',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.white)),
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  IconlyBroken.chat,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'message',
                                                  style: TextStyle(
                                                      color: Colors.black),
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
                    myDivider2(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          'Posts',
                          style: GoogleFonts.roboto(
                            fontSize: 24,
                            color:
                                cubit.isLight ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    space(0, 5),
                    ConditionalBuilder(
                        condition: posts.isNotEmpty,
                        builder: (context) => ListView.separated(
                          shrinkWrap: true,
physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => buildPost(
                                  index,
                                  context,
                                  state,
                                  posts[index],
                                  friendsModel,
                                  scaffoldKey,
                                  isSingle: false),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              itemCount: posts.length,
                            ),
                        fallback: (context) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                    height: 70,
                                  ),
                                  Icon(
                                    Icons.article_outlined,
                                    size: 70,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    'No Posts',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
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
