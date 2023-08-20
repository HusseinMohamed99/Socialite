import 'package:flutter/services.dart';
import 'package:sociality/layout/Home/home_layout.dart';
import 'package:sociality/shared/cubit/EmailVerification/email_verification_cubit.dart';
import 'package:sociality/shared/cubit/EmailVerification/email_verification_state.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/components/buttons.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
                ? AppColorsLight.primaryColor
                : AppColorsDark.primaryDarkColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,
              ),
              leading: IconButton(
                onPressed: () {
                  pop(context);
                },
                icon: Icon(
                  IconlyLight.arrowLeft2,
                  size: 30.sp,
                  color: SocialCubit.get(context).isDark
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    space(0, 35.h),
                    Container(
                      decoration: BoxDecoration(
                        color: SocialCubit.get(context).isDark
                            ? Colors.black
                            : Colors.white,
                        borderRadius: BorderRadius.circular(75.0).r,
                      ),
                      child: CircleAvatar(
                        radius: 80.0.r,
                        backgroundImage:
                            const AssetImage('assets/images/email.png'),
                      ),
                    ),
                    space(0, 15.h),
                    Text('Email Confirmation',
                        style: TextStyle(
                          fontSize: 24.0.sp,
                          color: SocialCubit.get(context).isDark
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                    space(0, 10.h),
                    Text(
                      'We\'re happy you signed up for Sociality App. To start exploring the \nSociality App,Please confirm your\nE-mail Address.',
                      style: GoogleFonts.libreBaskerville(
                        textStyle: TextStyle(
                          color: SocialCubit.get(context).isDark
                              ? Colors.blueGrey
                              : Colors.white,
                          fontSize: 20.sp,
                          overflow: TextOverflow.visible,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    space(0, 45.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0).r,
                      child: state is SendVerificationLoadingState
                          ? const CircularProgressIndicator()
                          : cubit.isEmailSent
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Card(
                                      color: SocialCubit.get(context).isDark
                                          ? Colors.green
                                          : Colors.white,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle_outline,
                                            color:
                                                SocialCubit.get(context).isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                            size: 24.sp,
                                          ),
                                          Text(
                                            'Email Verification Sent',
                                            style: GoogleFonts.libreBaskerville(
                                              textStyle: TextStyle(
                                                color: SocialCubit.get(context)
                                                        .isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    space(10.w, 0),
                                    TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          SocialCubit.get(context).isDark
                                              ? Colors.red
                                              : Colors.white,
                                        ),
                                      ),
                                      onPressed: () {
                                        cubit.sendEmailVerification();
                                      },
                                      child: Text(
                                        'Send again',
                                        style: GoogleFonts.libreBaskerville(
                                          textStyle: TextStyle(
                                            color:
                                                SocialCubit.get(context).isDark
                                                    ? Colors.white
                                                    : Colors.black,
                                            overflow: TextOverflow.visible,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Card(
                                  color: SocialCubit.get(context).isDark
                                      ? Colors.blue
                                      : Colors.grey,
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
                                  ? Colors.green
                                  : Colors.grey,
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
                                  ? Colors.blue
                                  : Colors.grey,
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
