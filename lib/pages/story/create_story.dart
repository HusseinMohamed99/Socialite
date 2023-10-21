import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/layout/Home/home_layout.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/components/indicator.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/components/show_toast.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';

class CreateStory extends StatelessWidget {
  const CreateStory({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is CreateStorySuccessState) {
          SocialCubit.get(context).getUserStories(uId);
          SocialCubit.get(context).getStories();
          showToast(
            text: AppString.createStorySuccessfully,
            state: ToastStates.success,
          );
          navigateAndFinish(context, const HomeLayout());
        }
        if (state is CreateStoryErrorState) {
          showToast(
            text: AppString.createStoryFailed,
            state: ToastStates.error,
          );
        }
      },
      builder: (context, state) {
        SocialCubit bloc = SocialCubit.get(context);
        final TextEditingController story = TextEditingController();
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(bloc.storyImage!),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppPadding.p8),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            child: ImageWithShimmer(
                              imageUrl: bloc.userModel!.image,
                              width: 60,
                              height: 60,
                              radius: 25,
                              boxFit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  SocialCubit.get(context).userModel!.name,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(width: 5),
                                const Icon(
                                  Icons.check_circle,
                                  color: ColorManager.blueColor,
                                )
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              bloc.closeStory(context);

                              bloc.addText = false;
                            },
                            icon: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 9,
                                    spreadRadius: 4,
                                    offset: const Offset(0, 4),
                                  )
                                ],
                              ),
                              child: CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: const Icon(
                                  Icons.close_rounded,
                                  color: ColorManager.redColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (bloc.addText == false) TextFieldForm(story: story),
                    Padding(
                      padding: const EdgeInsets.all(10.0).r,
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                bloc.addTextStory();
                              },
                              child: Container(
                                height: 35.h,
                                decoration: BoxDecoration(
                                  color: ColorManager.titanWithColor,
                                  borderRadius: BorderRadius.circular(15).r,
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorManager.greyColor
                                          .withOpacity(0.3),
                                      blurRadius: 9,
                                      spreadRadius: 4,
                                      offset: const Offset(0, 4),
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.text_fields,
                                      color: ColorManager.blackColor,
                                    ),
                                    Text(
                                      bloc.addText
                                          ? AppString.addText
                                          : AppString.removeText,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: ColorManager.blackColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                DateTime date = DateTime.now();
                                bloc.createStoryImage(
                                    text: story.text, dateTime: date);
                              },
                              child: Container(
                                height: 35.h,
                                decoration: BoxDecoration(
                                  color: ColorManager.titanWithColor,
                                  borderRadius: BorderRadius.circular(15).r,
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorManager.greyColor
                                          .withOpacity(0.3),
                                      blurRadius: 9,
                                      spreadRadius: 4,
                                      offset: const Offset(0, 4),
                                    )
                                  ],
                                ),
                                child: ConditionalBuilder(
                                  condition: state is! CreateStoryLoadingState,
                                  builder: (context) => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.upload,
                                        color: ColorManager.blackColor,
                                      ),
                                      Text(
                                        AppString.addStory,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                color: ColorManager.blackColor),
                                      )
                                    ],
                                  ),
                                  fallback: (context) => const Center(
                                    child: AdaptiveIndicator(),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class TextFieldForm extends StatelessWidget {
  const TextFieldForm({
    super.key,
    required this.story,
  });

  final TextEditingController story;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20).r,
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: 20,
        minLines: 1,
        style: Theme.of(context).textTheme.titleLarge,
        controller: story,
        decoration: InputDecoration(
          hintText: AppString.yourMind,
          hintStyle: Theme.of(context).textTheme.titleMedium,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
