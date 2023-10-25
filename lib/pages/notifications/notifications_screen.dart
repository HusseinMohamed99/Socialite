import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialite/image_assets.dart';
import 'package:socialite/shared/components/my_divider.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/value_manager.dart';
import 'package:socialite/shared/widget/notifications_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit cubit = SocialCubit.get(context);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                automaticallyImplyLeading: false,
                title: Text(
                  AppString.notifications,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(letterSpacing: 10),
                ),
              ),
              body: ConditionalBuilder(
                condition: cubit.notifications.isNotEmpty,
                builder: (context) => ListView.separated(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => NotificationsBuilder(
                    notifications: cubit.notifications[index],
                    cubit: cubit,
                  ),
                  separatorBuilder: (context, index) =>
                      const MyDivider(vertical: AppPadding.p8),
                  itemCount: cubit.notifications.length,
                ),
                fallback: (context) => Center(
                  child: SvgPicture.asset(Assets.imagesUndrawNotFound),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
