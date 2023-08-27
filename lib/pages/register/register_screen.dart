import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialite/image_assets.dart';
import 'package:socialite/pages/Login/login_screen.dart';
import 'package:socialite/pages/email_verification/email_verification_screen.dart';
import 'package:socialite/shared/components/buttons.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:socialite/shared/components/indicator.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/components/show_toast.dart';
import 'package:socialite/shared/components/text_form_field.dart';
import 'package:socialite/shared/cubit/registerCubit/cubit.dart';
import 'package:socialite/shared/cubit/registerCubit/state.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/network/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/shared/styles/color.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is UserCreateSuccessState) {
            CacheHelper.saveData(value: state.uid, key: 'uId').then((value) {
              uId = state.uid;
              navigateAndFinish(
                context,
                const EmailVerificationScreen(),
              );
            });
            SocialCubit.get(context).getUserData();
            SocialCubit.get(context).getPosts();
            SocialCubit.get(context).getAllUsers();
            SocialCubit.get(context).getStories();
            SocialCubit.get(context).setUserToken();
          }
          if (state is UserCreateErrorState) {
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
                            child: SvgPicture.asset(Assets.imagesGroup1320),
                          ),
                          Expanded(
                            flex: 2,
                            child: SvgPicture.asset(
                                Assets.imagesAchievementMonochromatic),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(15),
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
                                'Sign Up Now',
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
                                controller: nameController,
                                keyboardType: TextInputType.name,
                                prefix: Icons.person,
                                validate: (String? value) {
                                  if (value!.trim().isEmpty ||
                                      value.length < 3) {
                                    return 'Please enter a valid name';
                                  }
                                  return null;
                                },
                                label: 'Name',
                              ),
                              SizedBox(height: 15.h),
                              DefaultTextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                prefix: Icons.email,
                                validate: (String? value) {
                                  if (value!.trim().isEmpty ||
                                      value.length < 13) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                                label: 'Email',
                              ),
                              SizedBox(height: 15.h),
                              DefaultTextFormField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                prefix: Icons.phone,
                                validate: (String? value) {
                                  if (value!.trim().isEmpty ||
                                      value.length < 11 ||
                                      value.length > 11) {
                                    return 'An Egyptian phone number consisting of 11 digits';
                                  }
                                  return null;
                                },
                                label: 'Phone',
                              ),
                              SizedBox(height: 15.h),
                              DefaultTextFormField(
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                prefix: Icons.key,
                                suffix: RegisterCubit.get(context).suffix,
                                isPassword:
                                    RegisterCubit.get(context).isPassword,
                                suffixPressed: () {
                                  RegisterCubit.get(context).changePassword();
                                },
                                validate: (String? value) {
                                  if (value!.trim().isEmpty ||
                                      value.trim().length < 6) {
                                    return 'Please enter a valid password';
                                  }
                                  return null;
                                },
                                label: '*******',
                              ),
                              SizedBox(height: 15.h),
                              RegisterCubit.get(context).isCheck
                                  ? ConditionalBuilder(
                                      condition: state is! RegisterLoadingState,
                                      builder: (context) {
                                        return defaultMaterialButton(
                                          function: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              RegisterCubit.get(context)
                                                  .userRegister(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                                phone: phoneController.text,
                                                name: nameController.text,
                                              );
                                            }
                                          },
                                          text: 'Sign Up',
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
                                        'Sign Up'.toUpperCase(),
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
                                        AppMainColors.greyColor,
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
                              SizedBox(height: 15.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Have an account ?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: AppMainColors.blackColor),
                                  ),
                                  defaultTextButton(
                                    function: () {
                                      navigateTo(context, const LoginScreen());
                                    },
                                    text: 'Sign In'.toUpperCase(),
                                    color: AppMainColors.mainColor,
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

  Widget checkBox(BuildContext context, Color? color) {
    var cubit = RegisterCubit.get(context);
    return Checkbox.adaptive(
      side: BorderSide(
        color: color ?? AppMainColors.whiteColor,
      ),
      activeColor: AppMainColors.mainColor,
      value: cubit.isCheck,
      onChanged: (e) {
        cubit.boxCheck(e!);
      },
    );
  }
}
