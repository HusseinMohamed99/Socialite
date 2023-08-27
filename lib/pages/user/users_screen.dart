import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialite/shared/styles/color.dart';
import 'package:socialite/shared/widget/friends_item.dart';
import 'package:socialite/shared/widget/friends_requests.dart';
import 'package:socialite/shared/widget/peoples_may_know.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getFriendRequest();
        SocialCubit.get(context).getAllUsers();
        SocialCubit.get(context)
            .getFriends(SocialCubit.get(context).userModel!.uId);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            List<UserModel> peopleYouMayKnow =
                SocialCubit.get(context).users.cast<UserModel>();
            List<UserModel> friendRequests =
                SocialCubit.get(context).friendRequests.cast<UserModel>();
            List<UserModel> friends =
                SocialCubit.get(context).friends.cast<UserModel>();
            return SocialCubit.get(context).users.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          IconlyLight.chat,
                          size: 70.sp,
                          color: AppMainColors.greyColor,
                        ),
                        Text(
                          'No Users Yet,\nPlease Add\nSome Friends',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: onRefresh,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15).r,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15.h),
                            Text(
                              'Friend Request',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            ConditionalBuilder(
                              condition: friendRequests.isNotEmpty,
                              builder: (context) => ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    FriendRequestItems(
                                        userModel: friendRequests[index]),
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 10.w),
                                itemCount: friendRequests.length,
                              ),
                              fallback: (context) => Container(
                                padding: const EdgeInsets.only(
                                  top: 15,
                                  bottom: 5,
                                ).r,
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  'No Friend Request',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              'People May Know',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              height: 190.h,
                              width: 200.w,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10).r,
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return PeoplesMayKnow(
                                      userModel: peopleYouMayKnow[index]);
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(width: 10.w);
                                },
                                itemCount: peopleYouMayKnow.length,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              'Friends',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(height: 10.h),
                            ConditionalBuilder(
                              condition: friends.isNotEmpty,
                              builder: (context) => ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return FriendsBuildItems(
                                      userModel: friends[index]);
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(width: 10.w);
                                },
                                itemCount: friends.length,
                              ),
                              fallback: (context) => Container(
                                padding: const EdgeInsets.only(
                                  top: 15,
                                  bottom: 5,
                                ).r,
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  'No Friends',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
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

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    SocialCubit.get(BuildContext).getUserData();
    SocialCubit.get(BuildContext).getFriendRequest();
    SocialCubit.get(BuildContext).getAllUsers();
    SocialCubit.get(BuildContext)
        .getFriends(SocialCubit.get(BuildContext).userModel!.uId);
  }
}
