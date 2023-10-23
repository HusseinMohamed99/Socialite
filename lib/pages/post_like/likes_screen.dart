import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialite/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:socialite/shared/components/my_divider.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/value_manager.dart';
import 'package:socialite/shared/widget/users_liked_widget.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({
    required this.postID,
    Key? key,
  }) : super(key: key);
  final String postID;
  @override
  Widget build(BuildContext context) {
    SocialCubit cubit = SocialCubit.get(context);
    return BlocConsumer<SocialCubit, SocialStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              AppString.likes,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(letterSpacing: 10),
            ),
            automaticallyImplyLeading: false,
          ),
          body: ConditionalBuilder(
            condition: cubit.peopleReacted.isNotEmpty,
            builder: (BuildContext context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return UsersLikedItem(likeModel: cubit.peopleReacted[index]);
              },
              separatorBuilder: (context, index) =>
                  const MyDivider(vertical: AppPadding.p8),
              itemCount: cubit.peopleReacted.length,
            ),
            fallback: (BuildContext context) => Center(
              child: SvgPicture.asset(Assets.imagesUndrawNotFound),
            ),
          ),
        );
      },
      listener: (BuildContext context, state) {},
    );
  }
}
