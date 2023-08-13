import 'package:sociality/shared/components/buttons.dart';
import 'package:sociality/shared/components/check_box.dart';
import 'package:sociality/shared/components/text_form_field.dart';
import 'package:sociality/shared/cubit/loginCubit/state.dart';
import 'package:sociality/shared/components/components.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:sociality/shared/cubit/loginCubit/cubit.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/network/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociality/shared/styles/color.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            SocialCubit.get(context).getUserData();
            CacheHelper.saveData(value: state.uid, key: 'uId').then((value) {
              uId = state.uid;
              SocialCubit.get(context).getUserData();
              SocialCubit.get(context).getPosts();
              SocialCubit.get(context).getAllUsers();
              showToast(
                text: 'Login is successfully',
                state: ToastStates.success,
              );
            });
          } else if (state is LoginErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.error,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  Card(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      height: 800,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          DefaultTextFormField(
                            color: AppMainColors.greyColor,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            prefix: Icons.email,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                            label: 'Email',
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          DefaultTextFormField(
                            color: AppMainColors.greyColor,
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            prefix: Icons.key,
                            suffix: LoginCubit.get(context).suffix,
                            isPassword: LoginCubit.get(context).isPassword,
                            suffixPressed: () {
                              LoginCubit.get(context).changePassword();
                            },
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            label: 'Password',
                          ),
                          defaultTextButton(
                            function: () {},
                            text: "Forgot Password ?",
                            context: context,
                            color: AppMainColors.greyDarkColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          LoginCubit.get(context).isCheck
                              ? defaultMaterialButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                  text: 'Sign In',
                                  textColor: AppMainColors.whiteColor,
                                  radius: 15,
                                  context: context,
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height: 48.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15).r,
                                    color: AppMainColors.mainColor
                                        .withOpacity(0.4),
                                  ),
                                  child: Text(
                                    'Sign In'.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            color: AppMainColors.whiteColor),
                                  ),
                                ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  checkBox(
                                    context,
                                    color: AppMainColors.greyColor,
                                  ),
                                  Text(
                                    'By creating an account, you agree to our',
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 45.0).r,
                                child: Text(
                                  'Term and Conditions',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        height: 0.2,
                                        color: AppMainColors.greenColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // const Spacer(),
                  // Container(
                  //   width: double.infinity,
                  //   height: 43.h,
                  //   decoration:
                  //       const BoxDecoration(color: AppMainColors.orangeColor),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         'Don\'t have an account ?',
                  //         style: Theme.of(context).textTheme.titleLarge,
                  //       ),
                  //       defaultTextButton(
                  //         function: () {
                  //           navigateTo(context, const RegisterScreen());
                  //         },
                  //         text: 'Sign Up'.toUpperCase(),
                  //         color: AppMainColors.whiteColor,
                  //         context: context,
                  //       ),
                  //    ],
                  //  ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
