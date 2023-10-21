import 'package:flutter/services.dart';
import 'package:socialite/image_assets.dart';
import 'package:socialite/layout/Home/home_layout.dart';
import 'package:socialite/shared/components/indicator.dart';
import 'package:socialite/shared/components/show_toast.dart';
import 'package:socialite/shared/cubit/EmailVerification/email_verification_cubit.dart';
import 'package:socialite/shared/cubit/EmailVerification/email_verification_state.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
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
              body: SizedBox(
                height: screenHeight,
                width: screenWidth,
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * .1),
                      CircleAvatar(
                        radius: 83,
                        backgroundColor: SocialCubit.get(context).isDark
                            ? ColorManager.redColor
                            : ColorManager.yellowColor,
                        child: const CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage(Assets.imagesEmail),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        AppString.emailConfirmation,
                        style: textTheme.headlineMedium,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "We're happy you signed up for Socialite. To start exploring the Socialite,Please confirm your\nE-mail Address.",
                        style: textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 45.h),
                      state is SendVerificationLoadingState
                          ? const AdaptiveIndicator()
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
                                            style: textTheme.headlineSmall,
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
                                                : ColorManager.titanWithColor,
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
                                      : ColorManager.titanWithColor,
                                  child: defaultTextButton(
                                    context: context,
                                    function: () {
                                      cubit.sendEmailVerification();
                                    },
                                    text: AppString.sendEmail,
                                  ),
                                ),
                      SizedBox(height: 15.h),
                      cubit.isEmailSent
                          ? Card(
                              color: SocialCubit.get(context).isDark
                                  ? ColorManager.greenColor
                                  : ColorManager.titanWithColor,
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
                                  : ColorManager.titanWithColor,
                              child: defaultTextButton(
                                context: context,
                                function: () {},
                                text: AppString.verified,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
