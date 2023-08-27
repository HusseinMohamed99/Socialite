import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sociality/image_assets.dart';
import 'package:sociality/layout/Home/home_layout.dart';
import 'package:sociality/pages/email_verification/email_verification_screen.dart';
import 'package:sociality/pages/password/forget_password.dart';
import 'package:sociality/pages/register/register_screen.dart';
import 'package:sociality/shared/components/buttons.dart';
import 'package:sociality/shared/components/check_box.dart';
import 'package:sociality/shared/components/indicator.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/components/show_toast.dart';
import 'package:sociality/shared/components/text_form_field.dart';
import 'package:sociality/shared/cubit/loginCubit/state.dart';
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
              LoginCubit.get(context).loginReloadUser().then(
                (value) {
                  if (LoginCubit.get(context).isEmailVerified) {
                    navigateAndFinish(
                      context,
                      const HomeLayout(),
                    );
                  } else {
                    navigateAndFinish(
                      context,
                      const EmailVerificationScreen(),
                    );
                  }
                },
              );
              SocialCubit.get(context).getUserData();
              SocialCubit.get(context).getPosts();
              SocialCubit.get(context).getAllUsers();
              SocialCubit.get(context).getStories();

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
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            ),
            child: Scaffold(
              backgroundColor: SocialCubit.get(context).isDark
                  ? AppColorsLight.primaryColor
                  : AppColorsDark.primaryDarkColor,
              body: Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: SvgPicture.asset(
                              Assets.imagesGroup1318,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: SvgPicture.asset(
                              Assets.imagesWorldwidewebMonochromatic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(15).r,
                        decoration: BoxDecoration(
                          color: SocialCubit.get(context).isDark
                              ? AppMainColors.whiteColor
                              : AppMainColors.titanWithColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ).r,
                        ),
                        alignment: Alignment.topCenter,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Sign in Now',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(
                                      color: AppMainColors.blackColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                'Please enter your information',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: AppMainColors.greyColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              SizedBox(height: 20.h),
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
                              SizedBox(height: 15.h),
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
                              Align(
                                alignment: Alignment.bottomRight,
                                child: defaultTextButton(
                                  function: () {
                                    navigateTo(context, RestPasswordScreen());
                                  },
                                  text: "Forgot Password ?",
                                  context: context,
                                  color: AppMainColors.greyColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(height: 15.h),
                              LoginCubit.get(context).isCheck
                                  ? ConditionalBuilder(
                                      condition: state is! LoginLoadingState,
                                      builder: (context) {
                                        return defaultMaterialButton(
                                          function: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              LoginCubit.get(context).userLogin(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                              );
                                            }
                                          },
                                          text: 'Sign In',
                                          textColor: AppMainColors.whiteColor,
                                          radius: 10.r,
                                          context: context,
                                        );
                                      },
                                      fallback: (context) {
                                        return Center(
                                          child: AdaptiveIndicator(
                                            os: getOs(),
                                          ),
                                        );
                                      },
                                    )
                                  : Container(
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      height: 48.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10).r,
                                        color: AppMainColors.mainColor
                                            .withOpacity(0.4),
                                      ),
                                      child: Text(
                                        'Sign In'.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                              color: AppMainColors.whiteColor,
                                            ),
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                              color: AppMainColors.blackColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 45).r,
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
                              SizedBox(height: 40.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don\'t have an account ?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: AppMainColors.blackColor),
                                  ),
                                  defaultTextButton(
                                    function: () {
                                      navigateTo(
                                          context, const RegisterScreen());
                                    },
                                    text: 'Sign Up'.toUpperCase(),
                                    color: AppColorsLight.primaryColor,
                                    context: context,
                                  ),
                                ],
                              ),
                            ],
                          ),
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
