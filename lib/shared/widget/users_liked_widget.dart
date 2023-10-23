import 'package:flutter/material.dart';
import 'package:socialite/model/likes_model.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';

class UsersLikedItem extends StatelessWidget {
  const UsersLikedItem({
    super.key,
    required this.likeModel,
  });
  final LikesModel likeModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            child: ImageWithShimmer(
              imageUrl: likeModel.image,
              width: 40,
              height: 40,
              radius: 20,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            likeModel.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          if (uId != likeModel.uId)
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.greyColor.withOpacity(0.1),
                  elevation: 0,
                ),
                onPressed: () {
                  SocialCubit.get(context).addFriend(
                    friendName: likeModel.name,
                    friendImage: likeModel.image,
                    friendsUID: likeModel.uId,
                    friendBio: likeModel.bio,
                    friendCover: likeModel.cover,
                    friendEmail: likeModel.email,
                    friendPhone: likeModel.phone,
                  );
                  SocialCubit.get(context).getFriends(likeModel.uId);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(
                      Icons.person_add_alt_1_rounded,
                      color: ColorManager.blueColor,
                    ),
                    Text(
                      AppString.addFriend,
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
}
