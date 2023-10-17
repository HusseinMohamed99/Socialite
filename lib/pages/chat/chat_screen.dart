import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:socialite/Pages/chat/private_chat.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/components/indicator.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/shared/components/my_divider.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/shared/utils/color_manager.dart';

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
                      color: ColorManager.greyColor,
                    ),
                    Text(
                      'No Users Yet,\nPlease Add\nSome Friends',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: ConditionalBuilder(
                  condition: cubit.users.isNotEmpty,
                  builder: (BuildContext context) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 90.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10).r),
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              BuildUsersOnlineItems(users: cubit.users[index]),
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 5.w),
                          itemCount: cubit.users.length,
                        ),
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
}

class BuildUsersOnlineItems extends StatelessWidget {
  const BuildUsersOnlineItems({super.key, required this.users});
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
      child: Container(
        margin: EdgeInsetsDirectional.all(10.r),
        width: 60.w,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 26.r,
                  child: ImageWithShimmer(
                    radius: 25.r,
                    imageUrl: users.image,
                    width: 60.w,
                    height: 50.h,
                    boxFit: BoxFit.fill,
                  ),
                ),
                CircleAvatar(
                  radius: 8.r,
                  backgroundColor: ColorManager.whiteColor,
                  child: CircleAvatar(
                    radius: 5.r,
                    backgroundColor: ColorManager.greenColor,
                  ),
                ),
              ],
            ),
            Text(
              users.name,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w100, fontSize: 14.sp),
            )
          ],
        ),
      ),
    );
  }
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
        padding: const EdgeInsets.symmetric(vertical: 10).r,
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.r,
              child: ImageWithShimmer(
                radius: 25.r,
                imageUrl: users.image,
                width: 60.w,
                height: 50.h,
                boxFit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Text(
                users.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(width: 10.w),
            OutlinedButton.icon(
              onPressed: () {
                navigateTo(
                  context,
                  PrivateChatScreen(userModel: users),
                );
              },
              label: Text(
                'Message',
                style: Theme.of(context).textTheme.titleLarge,
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
