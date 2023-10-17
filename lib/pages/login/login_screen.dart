import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialite/image_assets.dart';
import 'package:socialite/layout/Home/home_layout.dart';
import 'package:socialite/pages/email_verification/email_verification_screen.dart';
import 'package:socialite/pages/password/forget_password.dart';
import 'package:socialite/pages/register/register_screen.dart';
import 'package:socialite/shared/components/buttons.dart';
import 'package:socialite/shared/components/check_box.dart';
import 'package:socialite/shared/components/indicator.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/components/show_toast.dart';
import 'package:socialite/shared/components/text_form_field.dart';
import 'package:socialite/shared/cubit/loginCubit/state.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:socialite/shared/cubit/loginCubit/cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/network/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';

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
            CacheHelper.saveData(value: state.uid, key: AppString.uId)
                .then((value) {
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
                text: AppString.loginSuccessfully,
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
                  ? ColorManager.primaryColor
                  : ColorManager.primaryDarkColor,
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
                              Assets.imagesWww,
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
                              ? ColorManager.whiteColor
                              : ColorManager.titanWithColor,
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
                                AppString.signInNow,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(
                                      color: ColorManager.blackColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                AppString.yourInformation,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: ColorManager.greyColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              SizedBox(height: 20.h),
                              DefaultTextFormField(
                                color: ColorManager.greyColor,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                prefix: Icons.email,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return AppString.enterEmail;
                                  }
                                  return null;
                                },
                                label: AppString.email,
                              ),
                              SizedBox(height: 15.h),
                              DefaultTextFormField(
                                color: ColorManager.greyColor,
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
                                    return AppString.enterPassword;
                                  }
                                  return null;
                                },
                                label: AppString.password,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: defaultTextButton(
                                  function: () {
                                    navigateTo(context, RestPasswordScreen());
                                  },
                                  text: AppString.forgotPassword,
                                  context: context,
                                  color: ColorManager.greyColor,
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
                                          text: AppString.signIn,
                                          textColor: ColorManager.whiteColor,
                                          radius: 10.r,
                                          context: context,
                                        );
                                      },
                                      fallback: (context) {
                                        return const Center(
                                          child: AdaptiveIndicator(),
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
                                        color: ColorManager.mainColor
                                            .withOpacity(0.4),
                                      ),
                                      child: Text(
                                        AppString.signIn.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                              color: ColorManager.whiteColor,
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
                                        color: ColorManager.greyColor,
                                      ),
                                      Text(
                                        AppString.youAgree,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                              color: ColorManager.blackColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 45).r,
                                    child: Text(
                                      AppString.conditions,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                            height: 0.2,
                                            color: ColorManager.greenColor,
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
                                    AppString.noAccount,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: ColorManager.blackColor),
                                  ),
                                  defaultTextButton(
                                    function: () {
                                      navigateTo(
                                          context, const RegisterScreen());
                                    },
                                    text: AppString.signUp.toUpperCase(),
                                    color: ColorManager.primaryColor,
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
