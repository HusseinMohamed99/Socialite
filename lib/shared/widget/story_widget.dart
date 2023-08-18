import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociality/model/story_model.dart';
import 'package:sociality/pages/story/veiw_story.dart';
import 'package:sociality/shared/components/image_with_shimmer.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({super.key, required this.cubit, required this.storyModel});
  final SocialCubit cubit;
  final StoryModel storyModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewStory(storyModel),
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
                  image: DecorationImage(
                    image: NetworkImage(storyModel.storyImage!),
                    fit: BoxFit.cover,
                  )),
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
                      backgroundImage: storyModel.uId == cubit.userModel!.uId
                          ? NetworkImage(cubit.userModel!.image)
                          : NetworkImage(storyModel.image!),
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
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
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
  }
}

class ListOfStoryItem extends StatelessWidget {
  const ListOfStoryItem({super.key, required this.cubit});
  final SocialCubit cubit;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0).r,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                cubit.getStoryImage(context);
              },
              child: Container(
                width: 110.w,
                height: 140.h,
                margin: EdgeInsetsDirectional.only(start: 8.r),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(17).r),
                child: Column(
                  children: [
                    SizedBox(
                      height: 125.h,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            child: ImageWithShimmer(
                              imageUrl: cubit.userModel!.image,
                              width: double.infinity,
                              height: double.infinity,
                              boxFit: BoxFit.fill,
                            ),
                          ),
                          CircleAvatar(
                            radius: 20.r,
                            backgroundColor: Colors.grey.withOpacity(0.3),
                            child: CircleAvatar(
                              radius: 18.r,
                              backgroundColor: Colors.blue,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 24.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Create Story",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.w),
            SizedBox(
              height: 140.h,
              child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  reverse: true,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      StoryItem(storyModel: cubit.stories[index], cubit: cubit),
                  separatorBuilder: (context, index) => SizedBox(width: 10.w),
                  itemCount: cubit.stories.length),
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }
}
