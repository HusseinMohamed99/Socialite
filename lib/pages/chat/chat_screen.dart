import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:f_app/Pages/chat/private_chat.dart';
import 'package:f_app/adaptive/indicator.dart';
import 'package:f_app/model/user_model.dart';
import 'package:f_app/shared/Cubit/socialCubit/social_cubit.dart';
import 'package:f_app/shared/Cubit/socialCubit/social_state.dart';
import 'package:f_app/shared/components/components.dart';
import 'package:f_app/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return SocialCubit.get(context).users.isEmpty
            ? Scaffold(
                body: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          IconlyLight.chat,
                          size: 70.sp,
                          color: Colors.grey,
                        ),
                        Center(
                          child: Text(
                            'No Users Yet,\nPlease Add\nSome Friends ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ]),
                ),
              )
            : SingleChildScrollView(
                child: ConditionalBuilder(
                  condition: cubit.users.isNotEmpty,
                  builder: (BuildContext context) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: Container(
                            height: 100.0.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10).r),
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  buildStoryItem(cubit.users[index], context),
                              separatorBuilder: (context, index) =>
                                  space(5.w, 0),
                              itemCount: cubit.users.length,
                            )),
                      ),
                      ListView.separated(
                        padding: const EdgeInsets.all(10.0).r,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildUsersItem(cubit.users[index], context),
                        separatorBuilder: (context, index) => myDivider(
                          Colors.grey.withOpacity(0.3),
                        ),
                        itemCount: cubit.users.length,
                      ),
                    ],
                  ),
                  fallback: (BuildContext context) => Center(
                    child: AdaptiveIndicator(
                      os: getOs(),
                    ),
                  ),
                ),
              );
      },
    );
  }

  Widget buildUsersItem(UserModel users, context) {
    return InkWell(
      onTap: () {
        navigateTo(
          context,
          PrivateChatScreen(userModel: users),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0).r,
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.r,
              backgroundImage: NetworkImage(
                users.image,
              ),
            ),
            space(15.w, 0),
            Expanded(
              child: Text(
                users.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                  fontSize: 20.sp,
                  color: SocialCubit.get(context).isLight
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
            space(10.sp, 0),
            OutlinedButton.icon(
              onPressed: () {
                navigateTo(
                  context,
                  PrivateChatScreen(userModel: users),
                );
              },
              label: Text(
                'Message',
                style: GoogleFonts.roboto(
                  fontSize: 15.sp,
                  height: 1.3.h,
                  color: SocialCubit.get(context).isLight
                      ? CupertinoColors.activeBlue
                      : Colors.white,
                ),
              ),
              icon: Icon(
                IconlyLight.chat,
                size: 24.sp,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildStoryItem(UserModel users, context) => InkWell(
        onTap: () {
          navigateTo(
            context,
            PrivateChatScreen(userModel: users),
          );
        },
        child: Container(
          margin: EdgeInsetsDirectional.all(10.r),
          width: 60.0.w,
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    radius: 26.0.r,
                    backgroundImage: NetworkImage(
                      users.image,
                    ),
                  ),
                  CircleAvatar(
                    radius: 8.0.r,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 5.0.r,
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),
              space(0, 5.h),
              Text(
                users.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 18.sp,
                  color: SocialCubit.get(context).isLight
                      ? Colors.black
                      : Colors.white,
                ),
              )
            ],
          ),
        ),
      );
}
