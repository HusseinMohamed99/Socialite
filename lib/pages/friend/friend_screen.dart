import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialite/image_assets.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/shared/components/my_divider.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/value_manager.dart';
import 'package:socialite/shared/widget/friends_widget.dart';

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
          SocialCubit cubit = SocialCubit.get(context);
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                AppString.friends,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(letterSpacing: 10),
              ),
            ),
            body: ConditionalBuilder(
              condition: friends!.isNotEmpty,
              builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => FriendsBuilderItems(
                  friendsModel: friends[index],
                  myFriend: myFriends ?? false,
                  cubit: cubit,
                ),
                separatorBuilder: (context, index) => const MyDivider(
                  vertical: AppPadding.p12,
                ),
                itemCount: friends.length,
              ),
              fallback: (context) => Center(
                child: SvgPicture.asset(Assets.imagesUndrawNotFound),
              ),
            ),
          );
        },
      );
    });
  }
}
