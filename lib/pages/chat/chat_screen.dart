import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:sociality/Pages/chat/private_chat.dart';
import 'package:sociality/shared/components/indicator.dart';
import 'package:sociality/model/user_model.dart';
import 'package:sociality/shared/components/my_divider.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/cubit/socialCubit/social_state.dart';
import 'package:sociality/shared/components/constants.dart';
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
            ? Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        IconlyLight.chat,
                        size: 70.sp,
                        color: Colors.grey,
                      ),
                      Text(
                        'No Users Yet,\nPlease Add\nSome Friends',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ]),
              )
            : SingleChildScrollView(
                child: ConditionalBuilder(
                  condition: cubit.users.isNotEmpty,
                  builder: (BuildContext context) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: Container(
                            height: 110.0.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10).r),
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  buildStoryItem(cubit.users[index], context),
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 5.w),
                              itemCount: cubit.users.length,
                            )),
                      ),
                      ListView.separated(
                        padding: const EdgeInsets.all(10.0).r,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => BuildUsersItems(
                          users: cubit.users[index],
                        ),
                        separatorBuilder: (context, index) => MyDivider(
                          color: Colors.grey.withOpacity(0.3),
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
              Text(
                users.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 16.sp,
                  color: SocialCubit.get(context).isDark
                      ? Colors.black
                      : Colors.white,
                ),
              )
            ],
          ),
        ),
      );
}

class BuildUsersItems extends StatelessWidget {
  const BuildUsersItems({super.key, required this.users});
  final UserModel users;
  @override
  Widget build(BuildContext context) {
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
                  color: SocialCubit.get(context).isDark
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
                  color: SocialCubit.get(context).isDark
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
}
