import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/shared/components/indicator.dart';
import 'package:socialite/shared/components/show_toast.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/widget/build_post_item.dart';
import 'package:socialite/shared/widget/profile_info.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

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
          showToast(text: "Likes Success!", state: ToastStates.success);
        }

        if (state is DisLikesSuccessState) {
          showToast(text: "UnLikes Success!", state: ToastStates.warning);
        }
      },
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        SocialCubit cubit = SocialCubit.get(context);
        return SocialCubit.get(context).userModel == null
            ? Scaffold(
                body: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        IconlyBroken.infoSquare,
                        size: 100.sp,
                        color: ColorManager.greyColor,
                      ),
                      Text(
                        'No Posts yet',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const CircularProgressIndicator(),
                    ],
                  ),
                ),
              )
            : AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                ),
                child: Scaffold(
                  body: cubit.userPosts.isEmpty
                      ? ProfileInfo(userModel: userModel, cubit: cubit)
                      : ConditionalBuilder(
                          condition: cubit.userPosts.isNotEmpty,
                          builder: (BuildContext context) =>
                              SingleChildScrollView(
                            child: Column(
                              children: [
                                ProfileInfo(userModel: userModel, cubit: cubit),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10.0,
                                    right: 10,
                                    top: 10,
                                  ).r,
                                  child: Align(
                                    alignment: AlignmentDirectional.topStart,
                                    child: Text(
                                      'Posts',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                  ),
                                ),
                                ListView.separated(
                                  padding: const EdgeInsets.only(top: 10).r,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: cubit.userPosts.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 10.h),
                                  itemBuilder: (context, index) =>
                                      (BuildPostItem(
                                    postModel: cubit.userPosts[index],
                                    userModel: cubit.userModel!,
                                    index: index,
                                  )),
                                ),
                              ],
                            ),
                          ),
                          fallback: (BuildContext context) => const Center(
                            child: AdaptiveIndicator(),
                          ),
                        ),
                ),
              );
      },
    );
  }
}
