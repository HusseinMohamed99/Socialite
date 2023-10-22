import 'package:flutter/services.dart';
import 'package:socialite/shared/components/indicator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/value_manager.dart';
import 'package:socialite/shared/widget/build_post_item.dart';
import 'package:socialite/shared/widget/profile_friends_info.dart';

class FriendsProfileScreen extends StatelessWidget {
  const FriendsProfileScreen(this.userUID, {Key? key}) : super(key: key);
  final String? userUID;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var friendsModel = SocialCubit.get(context).friendsProfile;
        SocialCubit cubit = SocialCubit.get(context);
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
          child: Scaffold(
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                SliverToBoxAdapter(
                  child:
                      ProfileFriendsInfo(userModel: friendsModel, cubit: cubit),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        AppString.post,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ),
                ),
                cubit.userPosts.isNotEmpty
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => BuildPostItem(
                            postModel: cubit.userPosts[index],
                            userModel: cubit.userModel!,
                            index: index,
                          ),
                          childCount: cubit.userPosts.length,
                        ),
                      )
                    : const SliverToBoxAdapter(
                        child: Center(
                          child: AdaptiveIndicator(),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
