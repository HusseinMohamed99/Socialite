import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:sociality/pages/addPost/add_post_screen.dart';
import 'package:sociality/shared/components/buttons.dart';
import 'package:sociality/shared/components/components.dart';
import 'package:sociality/shared/components/image_with_shimmer.dart';
import 'package:sociality/shared/components/indicator.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/cubit/socialCubit/social_state.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociality/shared/styles/color.dart';
import 'package:sociality/shared/widget/build_post_item.dart';
import 'package:sociality/shared/widget/story_widget.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SavedToGalleryLoadingState) {
          Navigator.pop(context);
        }
        if (state is SavedToGallerySuccessState) {
          showToast(text: "Downloaded to Gallery!", state: ToastStates.success);
        }
        if (state is LikesSuccessState) {
          showToast(text: "Likes Successfully!", state: ToastStates.success);
        }
        if (state is DisLikesSuccessState) {
          showToast(text: "UnLikes Successfully!", state: ToastStates.success);
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return cubit.posts.isNotEmpty || cubit.stories.isNotEmpty
            ? RefreshIndicator(
                onRefresh: () async {
                  cubit.getPosts();
                  return cubit.getUserData();
                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
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
                                  margin:
                                      EdgeInsetsDirectional.only(start: 8.r),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius:
                                          BorderRadius.circular(17).r),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 125.h,
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.bottomCenter,
                                          children: [
                                            Align(
                                              child: ImageWithShimmer(
                                                imageUrl:
                                                    cubit.userModel!.image,
                                                width: double.infinity,
                                                height: double.infinity,
                                                boxFit: BoxFit.fill,
                                              ),
                                            ),
                                            CircleAvatar(
                                              radius: 20.r,
                                              backgroundColor:
                                                  Colors.grey.withOpacity(0.3),
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    reverse: true,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => StoryItem(
                                          storyModel: cubit.stories[index],
                                        ),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(width: 10.w),
                                    itemCount: cubit.stories.length),
                              ),
                              SizedBox(width: 10.w),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 10,
                        margin: const EdgeInsets.all(10).r,
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 20.0).r,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25.r,
                                child: ImageWithShimmer(
                                  imageUrl: cubit.userModel!.image,
                                  width: 100.w,
                                  height: 100.h,
                                  boxFit: BoxFit.fill,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: 220.w,
                                  height: 35.h,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  margin: const EdgeInsets.all(10).r,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppMainColors.greyColor,
                                    ),
                                    borderRadius: BorderRadius.circular(25).r,
                                  ),
                                  child: TextButton(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    style: TextButton.styleFrom(
                                      backgroundColor: AppMainColors.greyColor
                                          .withOpacity(0.1),
                                    ),
                                    child: Text(
                                      "' What's on your mind ? '",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                              Container(
                                width: 2.w,
                                height: 50.h,
                                color: Colors.grey,
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.getPostImage();
                                  navigateTo(context, AddPostScreen());
                                },
                                icon: Icon(
                                  Icons.photo_library_outlined,
                                  size: 30.sp,
                                  color: cubit.isDark
                                      ? CupertinoColors.activeBlue
                                      : AppMainColors.whiteColor,
                                ),
                                splashRadius: 20.r,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cubit.posts.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10.h);
                        },
                        itemBuilder: (context, index) {
                          return BuildPostItem(
                            postModel: cubit.posts[index],
                            index: index,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            : ConditionalBuilder(
                condition: state is GetStorySuccessState &&
                    state is GetUserDataSuccessState,
                builder: (context) {
                  return Column(
                    children: [
                      SingleChildScrollView(
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
                                  margin:
                                      EdgeInsetsDirectional.only(start: 8.r),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius:
                                          BorderRadius.circular(17).r),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 125.h,
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.bottomCenter,
                                          children: [
                                            Align(
                                              child: ImageWithShimmer(
                                                imageUrl:
                                                    cubit.userModel!.image,
                                                width: double.infinity,
                                                height: double.infinity,
                                                boxFit: BoxFit.fill,
                                              ),
                                            ),
                                            CircleAvatar(
                                              radius: 20.r,
                                              backgroundColor:
                                                  Colors.grey.withOpacity(0.3),
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    reverse: true,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => StoryItem(
                                          storyModel: cubit.stories[index],
                                        ),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(width: 10.w),
                                    itemCount: cubit.stories.length),
                              ),
                              SizedBox(width: 10.w),
                            ],
                          ),
                        ),
                      ),
                      defaultTextButton(
                          function: () {
                            navigateTo(
                              context,
                              AddPostScreen(),
                            );
                          },
                          text: 'Create Posts',
                          context: context),
                      Column(
                        children: [
                          Icon(
                            IconlyLight.infoSquare,
                            size: 100.sp,
                            color: Colors.grey,
                          ),
                          Text(
                            'No Posts yet',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ],
                      ),
                    ],
                  );
                },
                fallback: (context) {
                  return AdaptiveIndicator(os: getOs());
                },
              );
      },
    );
  }
}
