import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/pages/story/create_story.dart';
import 'package:socialite/pages/story/view_story.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';
import 'package:socialite/shared/widget/build_stories_item.dart';
import 'package:socialite/shared/widget/user_stories.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double screenHeight = MediaQuery.sizeOf(context).height;

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is CreateStoryImagePickedSuccessState) {
          navigateTo(context, const CreateStory());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            if (cubit.stories.isNotEmpty)
              SliverToBoxAdapter(
                  child: CarouselSliderStories(
                cubit: cubit,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              )),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: Text(
                  AppString.myStories,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: CreateNewStories(
                cubit: cubit,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ),
            if (cubit.stories.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0).r,
                  child: Text(
                    AppString.allStories,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p12),
                child: GridView.count(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  reverse: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1 / 1.5,
                  children: List.generate(
                    cubit.stories.length,
                    (index) =>
                        BuildStoriesItem(storyModel: cubit.stories[index]),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CreateNewStories extends StatelessWidget {
  const CreateNewStories({
    super.key,
    required this.cubit,
    required this.screenWidth,
    required this.screenHeight,
  });

  final SocialCubit cubit;
  final double screenWidth;
  final double screenHeight;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              cubit.getStoryImage(context);
            },
            child: Container(
              width: screenWidth * .35,
              height: screenHeight * .25,
              margin: const EdgeInsets.only(left: AppMargin.m12),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(17),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * .2,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            width: double.infinity,
                            height: screenHeight * .18,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(17)),
                            ),
                            child: ImageWithShimmer(
                              imageUrl: cubit.userModel!.image,
                              width: 100,
                              height: 100,
                              radius: 15,
                              boxFit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.grey.withOpacity(0.3),
                          child: const CircleAvatar(
                            radius: 25,
                            backgroundColor: ColorManager.blueColor,
                            child: Icon(
                              IconlyBroken.plus,
                              color: ColorManager.titanWithColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    AppString.createStory,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: screenHeight * .25,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              reverse: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => UserStories(
                storyModel: cubit.userStories[index],
              ),
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemCount: cubit.userStories.length,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

class CarouselSliderStories extends StatelessWidget {
  const CarouselSliderStories({
    super.key,
    required this.cubit,
    required this.screenWidth,
    required this.screenHeight,
  });

  final SocialCubit cubit;
  final double screenWidth;
  final double screenHeight;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: cubit.stories
          .map(
            (e) => InkWell(
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
                    width: screenWidth,
                    height: screenHeight * .35,
                    margin: const EdgeInsets.all(AppMargin.m12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s50),
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context)
                                  .shadowColor
                                  .withOpacity(0.1),
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
                      radius: 45,
                      imageUrl: e.storyImage!,
                      width: double.infinity,
                      height: double.infinity,
                      boxFit: BoxFit.fitWidth,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          child: CircleAvatar(
                            radius: 22,
                            child: ImageWithShimmer(
                              imageUrl: e.image!,
                              width: 80,
                              height: 80,
                              radius: 20,
                              boxFit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              e.name!,
                              style: Theme.of(context).textTheme.titleLarge,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              daysBetween(
                                  DateTime.parse(e.dateTime!.toString())),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        reverse: false,
        scrollDirection: Axis.horizontal,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(seconds: 10),
        viewportFraction: 1,
        autoPlayCurve: Curves.decelerate,
        initialPage: 0,
        height: screenHeight * .35,
      ),
    );
  }
}
