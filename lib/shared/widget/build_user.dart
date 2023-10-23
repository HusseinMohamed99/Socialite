import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialite/Pages/chat/private_chat.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:flutter/material.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/value_manager.dart';

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
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              child: ImageWithShimmer(
                radius: 30,
                imageUrl: users.image,
                width: 60,
                height: 60,
                boxFit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                users.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(width: 10),
            OutlinedButton.icon(
              onPressed: () {
                navigateTo(
                  context,
                  PrivateChatScreen(userModel: users),
                );
              },
              label: Text(
                AppString.message,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              icon: const Icon(
                IconlyBroken.chat,
              ),
            )
          ],
        ),
      ),
    );
  }
}
