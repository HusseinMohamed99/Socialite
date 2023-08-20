import 'package:flutter/services.dart';
import 'package:sociality/layout/Home/home_layout.dart';
import 'package:sociality/shared/components/indicator.dart';
import 'package:sociality/shared/cubit/EmailVerification/email_verification_cubit.dart';
import 'package:sociality/shared/cubit/EmailVerification/email_verification_state.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/components/buttons.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/styles/color.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => EmailVerificationCubit(),
      child: BlocConsumer<EmailVerificationCubit, EmailVerificationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          EmailVerificationCubit cubit = EmailVerificationCubit.get(context);
          SocialCubit.get(context).getUserData();

          return Scaffold(
            backgroundColor: SocialCubit.get(context).isDark
                ? AppMainColors.kittenWithColor
                : AppColorsDark.primaryDarkColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,
              ),
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: SocialCubit.get(context).isDark
                            ? AppMainColors.redColor
                            : AppColorsDark.primaryDarkColor,
                        borderRadius: BorderRadius.circular(75.0).r,
                      ),
                      child: CircleAvatar(
                        radius: 80.0.r,
                        backgroundImage:
                            const AssetImage('assets/images/email.png'),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      'Email Confirmation',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "We're happy you signed up for Sociality App. To start exploring the \nSociality App,Please confirm your\nE-mail Address.",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppMainColors.greyColor),
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
                                      color: SocialCubit.get(context).isDark
                                          ? AppMainColors.greenColor
                                          : AppMainColors.whiteColor,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle_outline,
                                            color:
                                                SocialCubit.get(context).isDark
                                                    ? AppMainColors.whiteColor
                                                    : AppMainColors.blackColor,
                                            size: 24.sp,
                                          ),
                                          Text(
                                            'Email Verification Sent',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                    space(10.w, 0),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor:
                                            SocialCubit.get(context).isDark
                                                ? AppMainColors.redColor
                                                : AppMainColors.whiteColor,
                                      ),
                                      onPressed: () {
                                        cubit.sendEmailVerification();
                                      },
                                      child: Text(
                                        'Send again',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                    ),
                                  ],
                                )
                              : Card(
                                  color: SocialCubit.get(context).isDark
                                      ? AppMainColors.blueColor
                                      : AppMainColors.greyColor,
                                  child: defaultTextButton(
                                    context: context,
                                    function: () {
                                      cubit.sendEmailVerification();
                                    },
                                    text: 'Send Email',
                                  ),
                                ),
                    ),
                    space(0, 15.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0).r,
                      child: cubit.isEmailSent
                          ? Card(
                              color: SocialCubit.get(context).isDark
                                  ? AppMainColors.greenColor
                                  : AppMainColors.greyColor,
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
                                text: 'Verified, Go Home',
                              ),
                            )
                          : Card(
                              color: SocialCubit.get(context).isDark
                                  ? AppMainColors.blueColor
                                  : AppMainColors.greyColor,
                              child: defaultTextButton(
                                context: context,
                                function: () {},
                                text: 'Verified, Go Home',
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
