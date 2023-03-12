import 'package:f_app/layout/Home/home_layout.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:f_app/shared/components/components.dart';
import 'package:f_app/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/Cubit/EmailVerification/email_verification_cubit.dart';
import '../../shared/Cubit/EmailVerification/email_verification_state.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => EmailVerificationCubit(),
      child: BlocConsumer<EmailVerificationCubit, EmailVerificationStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var cubit = EmailVerificationCubit.get(context);
          var mode = SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  pop(context);
                },
                icon: Icon(
                  IconlyLight.arrowLeft2,
                  size: 30.sp,
                  color: mode.isLight ? Colors.black : Colors.white,
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
                        color: mode.isLight ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(75.0).r,
                      ),
                      child: CircleAvatar(
                        radius: 80.0.r,
                        backgroundImage: AssetImage('assets/images/email.png'),
                      ),
                    ),
                    space(0, 15.h),
                    Text('Email Confirmation',
                        style: TextStyle(
                          fontSize: 24.0.sp,
                          color: mode.isLight ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                    space(0, 10.h),
                    Text(
                      'We\'re happy you signed up for Sociality App. To start exploring the \nSociality App,Please confirm your\nE-mail Address.',
                      style: GoogleFonts.libreBaskerville(
                        textStyle: TextStyle(
                          color: mode.isLight ? Colors.blueGrey : Colors.white,
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
                                      color: mode.isLight
                                          ? Colors.green
                                          : Colors.white,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle_outline,
                                            color: mode.isLight
                                                ? Colors.white
                                                : Colors.black,
                                            size: 24.sp,
                                          ),
                                          Text(
                                            'Email Verification Sent',
                                            style: GoogleFonts.libreBaskerville(
                                              textStyle: TextStyle(
                                                color: mode.isLight
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
                                          mode.isLight
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
                                            color: mode.isLight
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
                                  color:
                                      mode.isLight ? Colors.blue : Colors.grey,
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
                              color: mode.isLight ? Colors.green : Colors.grey,
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
                              color: mode.isLight ? Colors.blue : Colors.grey,
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
