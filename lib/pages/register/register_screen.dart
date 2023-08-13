import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:sociality/adaptive/indicator.dart';
import 'package:sociality/pages/Login/login_screen.dart';
import 'package:sociality/pages/email_verification/email_verification_screen.dart';
import 'package:sociality/shared/Cubit/registerCubit/cubit.dart';
import 'package:sociality/shared/Cubit/registerCubit/state.dart';
import 'package:sociality/shared/Cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/components/components.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/components/text_form_field.dart';
import 'package:sociality/shared/network/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is UserCreateSuccessState) {
            CacheHelper.saveData(value: state.uid, key: 'uId').then((value) {
              uId = state.uid;
              navigateTo(
                context,
                const EmailVerificationScreen(),
              );
            });
            SocialCubit.get(context).getUserData();
            SocialCubit.get(context).getPosts();
            SocialCubit.get(context).getAllUsers();
          }
        },
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  pop(context);
                },
                icon: Icon(
                  IconlyLight.arrowLeft2,
                  size: 30.sp,
                  color: cubit.isLight ? Colors.black : Colors.white,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0).r,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        child: Text(
                          'Sign up Now',
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              color:
                                  cubit.isLight ? Colors.black : Colors.white,
                              fontSize: 40.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      space(0, 10.h),
                      Text(
                        'Please enter your information',
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      space(0, 20.h),
                      Text(
                        'Full Name',
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      space(0, 5.h),
                      DefaultTextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        validate: (String? value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter your phone';
                          }
                          return null;
                        },
                        label: 'Name',
                        prefix: Icons.person_outline_rounded,
                      ),
                      space(0, 10.h),
                      Text(
                        'Phone',
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      space(0, 5.h),
                      DefaultTextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validate: (String? value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter your phone';
                          }
                          return null;
                        },
                        label: 'Phone',
                        prefix: Icons.phone,
                      ),
                      space(0, 10.h),
                      Text(
                        'E-mail Address',
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      space(0, 5.h),
                      DefaultTextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter your E-mail';
                          }
                          return null;
                        },
                        label: 'E-mail',
                        prefix: Icons.alternate_email,
                      ),
                      space(0, 10.h),
                      Text(
                        'Password',
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      space(0, 5.h),
                      DefaultTextFormField(
                        controller: passController,
                        keyboardType: TextInputType.visiblePassword,
                        validate: (String? value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        label: 'Password',
                        prefix: Icons.lock_outline_rounded,
                        suffix: RegisterCubit.get(context).suffix,
                        isPassword: RegisterCubit.get(context).isPassword,
                        suffixPressed: () {
                          RegisterCubit.get(context).changePassword();
                        },
                      ),
                      space(0, 20.h),
                      Center(
                        child: ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defaultMaterialButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passController.text,
                                  phone: phoneController.text,
                                  name: nameController.text,
                                );
                              }
                            },
                            text: 'Register',
                          ),
                          fallback: (BuildContext context) => Center(
                            child: AdaptiveIndicator(
                              os: getOs(),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Already have an account?',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                color:
                                    cubit.isLight ? Colors.black : Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(
                                context,
                                const LoginScreen(),
                              );
                            },
                            child: Text(
                              'Login !'.toUpperCase(),
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
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
