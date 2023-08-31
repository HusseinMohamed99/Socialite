import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/model/story_model.dart';
import 'package:socialite/pages/story/veiw_story.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:socialite/shared/styles/color.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({super.key, required this.storyModel});
  final StoryModel storyModel;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);

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
            width: 110.w,
            height: 180.h,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(17).r,
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14).r,
                  ),
                  child: ImageWithShimmer(
                    radius: 15.r,
                    imageUrl: storyModel.storyImage!,
                    width: double.infinity,
                    height: double.infinity,
                    boxFit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 23.r,
                        child: CircleAvatar(
                          radius: 20.r,
                          child: storyModel.uId == cubit.userModel!.uId
                              ? ImageWithShimmer(
                                  imageUrl: cubit.userModel!.image,
                                  radius: 20.r,
                                  width: double.infinity,
                                  height: double.infinity,
                                  boxFit: BoxFit.fill,
                                )
                              : ImageWithShimmer(
                                  imageUrl: storyModel.image!,
                                  radius: 20.r,
                                  width: double.infinity,
                                  height: double.infinity,
                                  boxFit: BoxFit.fill,
                                ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 110.w,
                        height: 25.h,
                        child: Text(
                          storyModel.uId == cubit.userModel!.uId
                              ? cubit.userModel!.name
                              : storyModel.name!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: AppMainColors.titanWithColor),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
