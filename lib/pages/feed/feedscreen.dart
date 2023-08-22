import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:sociality/shared/components/image_with_shimmer.dart';
import 'package:sociality/shared/components/indicator.dart';
import 'package:sociality/shared/components/show_toast.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/cubit/socialCubit/social_state.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociality/shared/styles/color.dart';
import 'package:sociality/shared/widget/build_post_item.dart';
import 'package:sociality/shared/widget/create_post.dart';
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
        return cubit.posts.isNotEmpty
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
                      StoriesItem(cubit: cubit),
                      CreatePosts(cubit: cubit),
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
                            userModel: cubit.userModel!,
                            index: index,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            : ConditionalBuilder(
                condition: cubit.stories.isEmpty && cubit.userModel != null,
                builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      StoriesItem(cubit: cubit),
                      CreatePosts(cubit: cubit),
                      SizedBox(height: 40.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                  return Center(
                    child: AdaptiveIndicator(
                      os: getOs(),
                    ),
                  );
                },
              );
      },
    );
  }
}

class StoriesItem extends StatelessWidget {
  const StoriesItem({
    super.key,
    required this.cubit,
  });

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
                              radius: 10.r,
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
                              backgroundColor: AppMainColors.blueColor,
                              child: Icon(
                                Icons.add,
                                color: AppMainColors.kittenWithColor,
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
                  itemBuilder: (context, index) => StoryItem(
                        storyModel: cubit.stories[index],
                      ),
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
