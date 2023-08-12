import 'package:f_app/Pages/friend/profile_screen.dart';
import 'package:f_app/Pages/profile/my_profile_screen.dart';
import 'package:f_app/model/user_model.dart';
import 'package:f_app/shared/Cubit/socialCubit/social_cubit.dart';
import 'package:f_app/shared/Cubit/socialCubit/social_state.dart';
import 'package:f_app/shared/components/components.dart';
import 'package:f_app/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendsScreen extends StatelessWidget {
  final bool? myFriends;
  final List<UserModel>? friends;

  const FriendsScreen(this.friends, {Key? key, this.myFriends = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List<UserModel>? friends = this.friends;
          var cubit = SocialCubit.get(context);
          return SocialCubit.get(context).friends.isEmpty
              ? Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    elevation: 1,
                    leading: IconButton(
                      onPressed: () {
                        pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: cubit.isLight ? Colors.black : Colors.white,
                        size: 24.sp,
                      ),
                    ),
                    titleSpacing: 1,
                    title: Text(
                      'Friends',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: cubit.isLight ? Colors.black : Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  body: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          IconlyLight.infoSquare,
                          size: 100.sp,
                          color: Colors.grey,
                        ),
                        Text(
                          'No Friends yet',
                          style: GoogleFonts.libreBaskerville(
                            fontWeight: FontWeight.w700,
                            fontSize: 30.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    elevation: 1,
                    leading: IconButton(
                      onPressed: () {
                        pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: cubit.isLight ? Colors.black : Colors.white,
                        size: 24.sp,
                      ),
                    ),
                    titleSpacing: 1,
                    title: Text(
                      'Friends',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: cubit.isLight ? Colors.black : Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  body: //state is GetFriendLoadingState
                      friends!.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => chatBuildItem(
                                  context, friends[index], myFriends ?? false),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 0,
                              ),
                              itemCount: friends.length,
                            ));
        },
      );
    });
  }
}

Widget chatBuildItem(context, UserModel model, bool myFriends) {
  var cubit = SocialCubit.get(context);
  return InkWell(
    onTap: () {
      if (SocialCubit.get(context).userModel!.uId == model.uId) {
        navigateTo(
          context,
          const MyProfileScreen(),
        );
      } else {
        navigateTo(
          context,
          FriendsProfileScreen(model.uId),
        );
      }
    },
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(model.image),
            radius: 35.r,
          ),
          space(10.w, 0),
          Text(
            model.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.libreBaskerville(
              textStyle: TextStyle(
                color: cubit.isLight ? Colors.black : Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Spacer(),
          if (myFriends)
            PopupMenuButton(
              color: cubit.isLight ? Colors.black : Colors.white,
              onSelected: (value) {
                if (value == 'Unfriend') {
                  SocialCubit.get(context).unFriend(model.uId);
                }
              },
              child: Icon(
                IconlyLight.moreSquare,
                color: cubit.isLight ? Colors.black : Colors.white,
                size: 24.sp,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  height: 40.h,
                  value: 'Unfriend',
                  child: Row(
                    children: [
                      Icon(
                        IconlyLight.delete,
                        color: cubit.isLight ? Colors.white : Colors.black,
                        size: 24.sp,
                      ),
                      space(15.w, 0),
                      Text(
                        'Unfriend',
                        style: GoogleFonts.libreBaskerville(
                          textStyle: TextStyle(
                            color: cubit.isLight ? Colors.white : Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    ),
  );
}
