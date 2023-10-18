import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/Pages/friend/friends_profile_screen.dart';
import 'package:socialite/model/story_model.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialite/shared/utils/color_manager.dart';

class ViewStory extends StatelessWidget {
  final StoryModel storyModel;

  const ViewStory({Key? key, required this.storyModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var bloc = SocialCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
              child: Stack(
            children: [
              ImageWithShimmer(
                imageUrl: storyModel.storyImage!,
                width: double.infinity,
                height: double.infinity,
                boxFit: BoxFit.fitWidth,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0).r,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (storyModel.uId != bloc.userModel!.uId) {
                              bloc.getFriends(storyModel.uId!);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FriendsProfileScreen(storyModel.uId),
                                ),
                              );
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: CircleAvatar(
                            radius: 24.r,
                            child: ImageWithShimmer(
                              imageUrl: storyModel.image!,
                              width: 60.w,
                              height: 60.h,
                              boxFit: BoxFit.fill,
                              radius: 15.r,
                            ),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    storyModel.name!,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  SizedBox(width: 5.w),
                                  Icon(
                                    Icons.check_circle,
                                    color: ColorManager.blueColor,
                                    size: 24.sp,
                                  )
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                daysBetween(
                                  DateTime.parse(
                                    storyModel.dateTime.toString(),
                                  ),
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: ColorManager.greyColor),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      ColorManager.greyColor.withOpacity(0.3),
                                  blurRadius: 9,
                                  spreadRadius: 4,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: Icon(
                                Icons.close_rounded,
                                color: ColorManager.redColor,
                                size: 24.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                      child: Container(
                    color: ColorManager.blackColor.withOpacity(0.3),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 10.h),
                        if (storyModel.text != "")
                          Center(
                            child: Text(
                              storyModel.text!,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  )),
                ],
              )
            ],
          )),
        );
      },
    );
  }
}
