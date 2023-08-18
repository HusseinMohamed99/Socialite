import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociality/pages/addPost/add_post_screen.dart';
import 'package:sociality/shared/components/image_with_shimmer.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/cubit/socialCubit/social_state.dart';
import 'package:sociality/shared/styles/color.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({
    super.key,
    required this.cubit,
  });

  final SocialCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 10,
          margin: const EdgeInsets.all(10).r,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  child: ImageWithShimmer(
                    imageUrl: cubit.userModel!.image,
                    width: 100.w,
                    height: 100.h,
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
                        backgroundColor:
                            AppMainColors.greyColor.withOpacity(0.1),
                      ),
                      child: Text(
                        "' What's on your mind ? '",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      onPressed: () {
                        navigateTo(
                          context,
                          AddPostScreen(),
                        );
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
        );
      },
    );
  }
}
