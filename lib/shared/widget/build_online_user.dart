import 'package:socialite/Pages/chat/private_chat.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:flutter/material.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';

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
        margin: const EdgeInsetsDirectional.all(AppPadding.p12),
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: ImageWithShimmer(
                    radius: 30,
                    imageUrl: users.image,
                    width: 60,
                    height: 60,
                    boxFit: BoxFit.fill,
                  ),
                ),
                const CircleAvatar(
                  radius: 8,
                  backgroundColor: ColorManager.whiteColor,
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: ColorManager.greenColor,
                  ),
                ),
              ],
            ),
            Text(
              users.name,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        ),
      ),
    );
  }
}
