import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociality/model/likes_model.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:sociality/shared/components/indicator.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/cubit/socialCubit/social_state.dart';
import 'package:sociality/shared/styles/color.dart';

class LikesScreen extends StatelessWidget {
  final String? postId;
  LikesScreen(
    this.postId, {
    Key? key,
  }) : super(key: key);
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SocialCubit cubit = SocialCubit.get(context);
    return BlocConsumer<SocialCubit, SocialStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                'Likes',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              automaticallyImplyLeading: true,
              leading: IconButton(
                onPressed: () {
                  pop(context);
                },
                icon: Icon(
                  IconlyLight.arrowLeft2,
                  size: 30.sp,
                  color: cubit.isDark
                      ? AppMainColors.blackColor
                      : AppMainColors.titanWithColor,
                ),
              ),
              elevation: 0,
            ),
            body: cubit.peopleReacted.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No likes yet,\nPut your like",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          "First Like ❤️",
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      ],
                    ),
                  )
                : ConditionalBuilder(
                    condition: cubit.peopleReacted.isNotEmpty,
                    builder: (BuildContext context) => Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  reverse: false,
                                  itemBuilder: (context, index) {
                                    return userLikeItem(
                                        context, cubit.peopleReacted[index]);
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 0,
                                      ),
                                  itemCount: cubit.peopleReacted.length),
                            ),
                          ],
                        ),
                    fallback: (BuildContext context) =>
                        AdaptiveIndicator(os: getOs())));
      },
      listener: (BuildContext context, state) {},
    );
  }
}

Widget userLikeItem(context, LikesModel like) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(like.image),
          radius: 20,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          like.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        if (uId != like.uId)
          SizedBox(
            width: 125.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppMainColors.greyColor.withOpacity(0.1),
                elevation: 0,
              ),
              onPressed: () {
                SocialCubit.get(context).addFriend(
                  friendName: like.name,
                  friendImage: like.image,
                  friendsUID: like.uId,
                  friendBio: like.bio,
                  friendCover: like.cover,
                  friendEmail: like.email,
                  friendPhone: like.phone,
                );
                SocialCubit.get(context).getFriends(like.uId);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.person_add_alt_1_rounded,
                    size: 15.sp,
                    color: AppMainColors.blueColor,
                  ),
                  Text(
                    'add Friend',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          )
      ],
    ),
  );
}
