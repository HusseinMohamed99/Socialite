import 'package:socialite/shared/components/indicator.dart';
import 'package:socialite/shared/components/show_toast.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/widget/build_post_item.dart';
import 'package:socialite/shared/widget/create_post.dart';
import 'package:socialite/shared/widget/stories_widget.dart';

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
          showToast(
              text: AppString.downloadedToGallery, state: ToastStates.success);
        }
        if (state is LikesSuccessState) {
          showToast(
              text: AppString.likesSuccessfully, state: ToastStates.success);
        }
        if (state is DisLikesSuccessState) {
          showToast(
              text: AppString.unLikesSuccessfully, state: ToastStates.success);
        }
      },
      builder: (context, state) {
        final double screenHeight = MediaQuery.sizeOf(context).height;
        final double screenWidth = MediaQuery.sizeOf(context).width;

        var cubit = SocialCubit.get(context);
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverToBoxAdapter(
              child: StoriesItem(
                cubit: cubit,
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              ),
            ),
            SliverToBoxAdapter(
              child: CreatePosts(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            if (cubit.posts.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return BuildPostItem(
                      postModel: cubit.posts[index],
                      userModel: cubit.userModel,
                      index: index,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                    );
                  },
                  childCount: cubit.posts.length,
                ),
              )
            else
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: AdaptiveIndicator(),
                ),
              ),
          ],
        );
      },
    );
  }
}
