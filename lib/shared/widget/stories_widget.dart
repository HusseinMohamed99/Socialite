import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialite/image_assets.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';
import 'package:socialite/shared/widget/story_widget.dart';

class StoriesItem extends StatelessWidget {
  const StoriesItem({
    super.key,
    required this.cubit,
    required this.screenHeight,
    required this.screenWidth,
  });

  final SocialCubit cubit;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                cubit.getStoryImage(context);
              },
              child: Container(
                width: screenWidth * .3,
                height: screenHeight * .22,
                margin: const EdgeInsetsDirectional.only(start: AppPadding.p8),
                decoration: BoxDecoration(
                  color: ColorManager.greyColor,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: cubit.userModel?.image != null
                              ? ImageWithShimmer(
                                  imageUrl: cubit.userModel!.image,
                                  radius: 10,
                                  width: double.infinity,
                                  height: screenHeight * .18,
                                  boxFit: BoxFit.fill,
                                )
                              : SvgPicture.asset(Assets.images404error),
                        ),
                        CircleAvatar(
                          backgroundColor:
                              ColorManager.greyColor.withOpacity(0.3),
                          child: const CircleAvatar(
                            backgroundColor: ColorManager.blueColor,
                            child: Icon(
                              IconlyBroken.plus,
                              color: ColorManager.titanWithColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Text(
                      AppString.createStory,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              height: screenHeight * .22,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                reverse: true,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => StoryItem(
                  storyModel: cubit.stories[index],
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: cubit.stories.length,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
