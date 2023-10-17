import 'package:flutter/services.dart';
import 'package:socialite/image_assets.dart';
import 'package:socialite/layout/Home/home_layout.dart';
import 'package:socialite/shared/components/indicator.dart';
import 'package:socialite/shared/components/show_toast.dart';
import 'package:socialite/shared/cubit/EmailVerification/email_verification_cubit.dart';
import 'package:socialite/shared/cubit/EmailVerification/email_verification_state.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/components/buttons.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => EmailVerificationCubit(),
      child: BlocConsumer<EmailVerificationCubit, EmailVerificationStates>(
        listener: (context, state) {
          if (state is ReloadSuccessState) {
            showToast(
              text: AppString.createAccountSuccessfully,
              state: ToastStates.success,
            );
            SocialCubit.get(context).getUserData();
            SocialCubit.get(context).getPosts();
            SocialCubit.get(context).getAllUsers();
            SocialCubit.get(context).getStories();
          }
          if (state is ReloadErrorState) {
            showToast(
              text: state.errorString!,
              state: ToastStates.error,
            );
          }
        },
        builder: (context, state) {
          EmailVerificationCubit cubit = EmailVerificationCubit.get(context);
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            ),
            child: Scaffold(
              backgroundColor: SocialCubit.get(context).isDark
                  ? ColorManager.titanWithColor
                  : ColorManager.primaryDarkColor,
              body: Padding(
                padding: const EdgeInsets.all(20.0).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.h),
                    Container(
                      decoration: BoxDecoration(
                        color: SocialCubit.get(context).isDark
                            ? ColorManager.redColor
                            : ColorManager.primaryDarkColor,
                        borderRadius: BorderRadius.circular(75.0).r,
                      ),
                      child: CircleAvatar(
                        radius: 80.0.r,
                        backgroundImage: const AssetImage(Assets.imagesEmail),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      AppString.emailConfirmation,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "We're happy you signed up for socialite App. To start exploring the \nSocialite App,Please confirm your\nE-mail Address.",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              fontWeight: FontWeight.w400,
                              color: ColorManager.greyColor),
                    ),
                    SizedBox(height: 45.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0).r,
                      child: state is SendVerificationLoadingState
                          ? AdaptiveIndicator(os: getOs())
                          : cubit.isEmailSent
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Card(
                                      color: ColorManager.greenColor,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle_outline,
                                            color:
                                                SocialCubit.get(context).isDark
                                                    ? ColorManager.whiteColor
                                                    : ColorManager.blackColor,
                                            size: 24.sp,
                                          ),
                                          Text(
                                            AppString.emailVerification,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor:
                                            SocialCubit.get(context).isDark
                                                ? ColorManager.redColor
                                                : ColorManager.greyColor,
                                      ),
                                      onPressed: () {
                                        cubit.sendEmailVerification();
                                      },
                                      child: Text(
                                        AppString.sendAgain,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                    ),
                                  ],
                                )
                              : Card(
                                  color: SocialCubit.get(context).isDark
                                      ? ColorManager.blueColor
                                      : ColorManager.greyColor,
                                  child: defaultTextButton(
                                    context: context,
                                    function: () {
                                      cubit.sendEmailVerification();
                                    },
                                    text: AppString.sendEmail,
                                  ),
                                ),
                    ),
                    SizedBox(height: 15.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0).r,
                      child: cubit.isEmailSent
                          ? Card(
                              color: SocialCubit.get(context).isDark
                                  ? ColorManager.greenColor
                                  : ColorManager.greyColor,
                              child: defaultTextButton(
                                context: context,
                                function: () {
                                  cubit.reloadUser().then(
                                    (value) {
                                      if (cubit.isEmailVerified) {
                                        SocialCubit.get(context)
                                          ..getPosts()
                                          ..getUserData()
                                          ..getAllUsers();
                                        SocialCubit.get(context).getUserData();
                                        navigateAndFinish(
                                          context,
                                          const HomeLayout(),
                                        );
                                      } else {}
                                    },
                                  );
                                },
                                text: AppString.verified,
                              ),
                            )
                          : Card(
                              color: SocialCubit.get(context).isDark
                                  ? ColorManager.blueColor
                                  : ColorManager.greyColor,
                              child: defaultTextButton(
                                context: context,
                                function: () {},
                                text: AppString.verified,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
