import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/pages/addPost/add_post_screen.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:socialite/shared/utils/color_manager.dart';

class CreatePosts extends StatelessWidget {
  const CreatePosts({
    super.key,
    required this.cubit,
  });

  final SocialCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 10,
          shadowColor: ColorManager.titanWithColor,
          margin: const EdgeInsets.all(10).r,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  child: ImageWithShimmer(
                    radius: 25.r,
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
                        color: ColorManager.greyColor.withOpacity(0.1),
                      ),
                      borderRadius: BorderRadius.circular(25).r,
                    ),
                    child: TextButton(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                      child: Text(
                        "' What's on your mind ? '",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      onPressed: () {
                        navigateTo(context, const AddPostScreen());
                      },
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
                    navigateTo(context, const AddPostScreen());
                  },
                  icon: Icon(
                    Icons.photo_library_outlined,
                    size: 30.sp,
                    color: cubit.isDark
                        ? CupertinoColors.activeBlue
                        : ColorManager.whiteColor,
                  ),
                  splashRadius: 20.r,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
