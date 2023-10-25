import 'package:socialite/model/user_model.dart';
import 'package:socialite/shared/components/show_toast.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/value_manager.dart';
import 'package:socialite/shared/widget/friends_item.dart';
import 'package:socialite/shared/widget/friends_requests.dart';
import 'package:socialite/shared/widget/peoples_may_know.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is FriendRequestSuccessState) {
          showToast(
            text: AppString.checkFriendRequest,
            state: ToastStates.success,
          );
        }
      },
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        List<UserModel> peopleYouMayKnow = cubit.users.cast<UserModel>();
        List<UserModel> friendRequests = cubit.friendRequests.cast<UserModel>();
        List<UserModel> friends = cubit.friends.cast<UserModel>();
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            if (friendRequests.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p12,
                  ),
                  child: Text(
                    AppString.friendRequest,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return FriendRequestItems(userModel: friendRequests[index]);
                },
                childCount: friendRequests.length,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            if (peopleYouMayKnow.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p12,
                  ),
                  child: Text(
                    AppString.peopleMayKnow,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: screenHeight * .4,
                child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return PeoplesMayKnow(
                      userModel: peopleYouMayKnow[index],
                      socialCubit: cubit,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 10);
                  },
                  itemCount: peopleYouMayKnow.length,
                ),
              ),
            ),
            if (friends.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p12,
                  ),
                  child: Text(
                    AppString.friends,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return FriendsBuildItems(userModel: friends[index]);
                },
                childCount: friends.length,
              ),
            ),
          ],
        );
      },
    );
  }
}
