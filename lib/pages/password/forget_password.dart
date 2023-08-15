import 'package:sociality/Pages/Login/login_screen.dart';
import 'package:sociality/shared/components/indicator.dart';
import 'package:sociality/shared/Cubit/restPasswordCubit/rest_password_cubit.dart';
import 'package:sociality/shared/Cubit/restPasswordCubit/rest_password_state.dart';
import 'package:sociality/shared/Cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/components/buttons.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/components/text_form_field.dart';

class RestPasswordScreen extends StatelessWidget {
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  RestPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordStates>(
        listener: (context, state) {
          if (state is ResetPasswordSuccessState) {
            navigateAndFinish(context, const LoginScreen());
          }
        },
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 1,
              leading: IconButton(
                onPressed: () {
                  emailController.clear();
                  pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: cubit.isDark ? Colors.black : Colors.white,
                ),
              ),
              titleSpacing: 1,
              title: Text(
                'Forget Password',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    color: cubit.isDark ? Colors.black : Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            body: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Resetpassword.png'),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20).r,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enter the E-mail address associated with your account',
                              style: GoogleFonts.libreBaskerville(
                                fontSize: 27.sp,
                                fontWeight: FontWeight.w900,
                                color:
                                    cubit.isDark ? Colors.black : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 150.h,
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.fromSTEB(
                          15.r,
                          20.r,
                          15.r,
                          0.r,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurStyle: BlurStyle.outer,
                              color: cubit.isDark
                                  ? const Color(0xff404258)
                                  : Colors.white,
                              blurRadius: 9,
                              spreadRadius: 10.r,
                              offset: const Offset(0, 1),
                            )
                          ],
                          border: Border.all(
                            color: cubit.isDark
                                ? const Color(0xff404258)
                                : Colors.white,
                          ),
                          color: cubit.isDark
                              ? Colors.white
                              : const Color(0xff404258),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(50.0),
                            topLeft: Radius.circular(50.0),
                          ).r,
                        ),
                        child: Form(
                          key: loginFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              space(0, 10.h),
                              DefaultTextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                prefix: Icons.email,
                                validate: (value) {
                                  if (value!.trim().isEmpty) {
                                    return 'Enter Your E-mail';
                                  }
                                  return null;
                                },
                                label: 'E-mail Address',
                              ),
                              const Spacer(),
                              state is ResetPasswordLoadingState
                                  ? Center(
                                      child: AdaptiveIndicator(
                                        os: getOs(),
                                      ),
                                    )
                                  : Container(
                                      color: Colors.blue,
                                      child: defaultTextButton(
                                        context: context,
                                        text: 'RESET PASSWORD',
                                        function: () {
                                          if (loginFormKey.currentState!
                                              .validate()) {
                                            ResetPasswordCubit.get(context)
                                                .resetPassword(
                                              email: emailController.text,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
