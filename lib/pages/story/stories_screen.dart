import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociality/pages/story/veiw_story.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:sociality/shared/components/image_with_shimmer.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/cubit/socialCubit/social_state.dart';
import 'package:sociality/shared/styles/color.dart';
import 'package:sociality/shared/widget/build_stories_item.dart';
import 'package:sociality/shared/widget/user_stories.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSliderStories(cubit: cubit),
              Padding(
                padding: const EdgeInsets.all(8.0).r,
                child: Text(
                  "My Stories",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              CreateNewStories(cubit: cubit),
              Padding(
                padding: const EdgeInsets.all(8.0).r,
                child: Text(
                  "All Stories",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0).r,
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  reverse: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1 / 1.5,
                  children: List.generate(
                    cubit.stories.length,
                    (index) =>
                        BuildStoriesItem(storyModel: cubit.stories[index]),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CreateNewStories extends StatelessWidget {
  const CreateNewStories({
    super.key,
    required this.cubit,
  });

  final SocialCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            cubit.getStoryImage(context);
          },
          child: Container(
            width: 110.w,
            height: 140.h,
            margin: const EdgeInsets.only(left: 8).r,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(17).r,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 120.h,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          width: double.infinity,
                          height: 120.h,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(17),
                              topLeft: Radius.circular(17),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ).r,
                          ),
                          child: ImageWithShimmer(
                            imageUrl: cubit.userModel!.image,
                            width: 100.w,
                            height: 100.h,
                            radius: 15.r,
                            boxFit: BoxFit.fill,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 20.r,
                        backgroundColor: Colors.grey.withOpacity(0.3),
                        child: CircleAvatar(
                          radius: 18.r,
                          backgroundColor: AppMainColors.blueColor,
                          child: Icon(
                            Icons.add,
                            size: 24.sp,
                            color: AppMainColors.kittenWithColor,
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
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            reverse: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => UserStories(
              storyModel: cubit.userStories[index],
            ),
            separatorBuilder: (context, index) => SizedBox(width: 10.w),
            itemCount: cubit.userStories.length,
          ),
        ),
        SizedBox(width: 10.w),
      ],
    );
  }
}

class CarouselSliderStories extends StatelessWidget {
  const CarouselSliderStories({
    super.key,
    required this.cubit,
  });

  final SocialCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: cubit.stories
            .map((e) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewStory(storyModel: e)));
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 230.h,
                        margin: const EdgeInsets.all(10).r,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                            ).r,
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context)
                                      .shadowColor
                                      .withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 9,
                                  offset: const Offset(3, 3)),
                              BoxShadow(
                                  color: Theme.of(context)
                                      .shadowColor
                                      .withOpacity(0.4),
                                  spreadRadius: 3,
                                  blurRadius: 9,
                                  offset: const Offset(-1, -1))
                            ]),
                        child: ImageWithShimmer(
                          radius: 15.r,
                          imageUrl: e.storyImage!,
                          width: double.infinity,
                          height: double.infinity,
                          boxFit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0).r,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20.r,
                              child: CircleAvatar(
                                radius: 18.r,
                                child: ImageWithShimmer(
                                  imageUrl: e.image!,
                                  width: 60.w,
                                  height: 60.h,
                                  radius: 15.r,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  e.name!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          color: AppMainColors.titanWithColor),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  daysBetween(
                                      DateTime.parse(e.dateTime!.toString())),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppMainColors.greyColor,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
            .toList(),
        options: CarouselOptions(
          reverse: false,
          scrollDirection: Axis.horizontal,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(seconds: 2),
          viewportFraction: 1,
          autoPlayCurve: Curves.easeOutSine,
          initialPage: 0,
          height: 200.h,
        ));
  }
}
