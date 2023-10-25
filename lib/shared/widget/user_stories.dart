import 'package:flutter/material.dart';
import 'package:socialite/model/story_model.dart';
import 'package:socialite/pages/story/view_story.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';

class UserStories extends StatelessWidget {
  const UserStories({super.key, required this.storyModel});
  final StoryModel storyModel;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double screenHeight = MediaQuery.sizeOf(context).height;
    SocialCubit bloc = SocialCubit.get(context);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewStory(storyModel: storyModel),
          ),
        );
      },
      child: Container(
        width: screenWidth * .35,
        height: screenHeight * .3,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(17),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: ImageWithShimmer(
                imageUrl: storyModel.storyImage!,
                width: double.infinity,
                height: double.infinity,
                boxFit: BoxFit.fitHeight,
                radius: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 23,
                    child: CircleAvatar(
                      radius: 20,
                      child: ImageWithShimmer(
                        imageUrl: bloc.userModel!.image,
                        width: 50,
                        height: 50,
                        boxFit: BoxFit.fill,
                        radius: 25,
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 110,
                    child: Text(
                      bloc.userModel!.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: ColorManager.blackColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
