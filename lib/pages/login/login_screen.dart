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
import 'package:socialite/shared/utils/my_validators.dart';
import 'package:socialite/shared/utils/value_manager.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordFocusNode = FocusNode();
    final emailFocusNode = FocusNode();
    final formKey = GlobalKey<FormState>();

    TextTheme textTheme = Theme.of(context).textTheme;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
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
            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: Form(
                key: formKey,
                child: Column(
                  children: [
                    const ImagesWidget(),
                    Expanded(
                      flex: 2,
                      child: Card(
                        margin: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(AppPadding.p16),
                          alignment: Alignment.topCenter,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            child: LoginWidget(
                              textTheme: textTheme,
                              emailController: emailController,
                              emailFocusNode: emailFocusNode,
                              passwordFocusNode: passwordFocusNode,
                              passwordController: passwordController,
                              formKey: formKey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    super.key,
    required this.textTheme,
    required this.emailController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.passwordController,
    required this.formKey,
  });

  final TextTheme textTheme;
  final TextEditingController emailController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
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
            // SocialCubit.get(context).getPosts();
            // SocialCubit.get(context).getAllUsers();
            // SocialCubit.get(context).getStories();

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
      builder: (BuildContext context, LoginStates state) {
        return Column(
          children: [
            Text(
              AppString.signInNow,
              style: textTheme.displayLarge,
            ),
            SizedBox(height: 10.h),
            Text(
              AppString.yourInformation,
              style: textTheme.titleMedium,
            ),
            SizedBox(height: 20.h),
            CustomTextFormField(
              controller: emailController,
              textInputType: TextInputType.emailAddress,
              prefixIcon: Icons.email,
              validator: (String? value) {
                return MyValidators.emailValidator(value);
              },
              hintText: AppString.email,
              focusNode: emailFocusNode,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(passwordFocusNode);
              },
            ),
            SizedBox(height: 15.h),
            CustomTextFormField(
              controller: passwordController,
              focusNode: passwordFocusNode,
              textInputType: TextInputType.visiblePassword,
              prefixIcon: Icons.key,
              suffixIcon: LoginCubit.get(context).suffix,
              obscureText: LoginCubit.get(context).isPassword,
              suffixIconOnTap: () {
                LoginCubit.get(context).changePassword();
              },
              validator: (value) {
                return MyValidators.passwordValidator(value);
              },
              hintText: AppString.password,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {},
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: defaultTextButton(
                function: () {
                  navigateTo(context, const ResetPasswordScreen());
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
                        color: ColorManager.mainColor,
                        function: () {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        text: AppString.signIn,
                        textColor: ColorManager.whiteColor,
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
                    height: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorManager.mainColor.withOpacity(0.4),
                    ),
                    child: Text(
                      AppString.signIn.toUpperCase(),
                      style: Theme.of(context).textTheme.headlineMedium,
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
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 45).r,
                  child: Text(
                    AppString.conditions,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          height: 0.2,
                          color: ColorManager.blueColor,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppString.noAccount,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                defaultTextButton(
                  function: () {
                    navigateTo(context, const RegisterScreen());
                  },
                  text: AppString.signUp.toUpperCase(),
                  color: ColorManager.greenColor,
                  context: context,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class ImagesWidget extends StatelessWidget {
  const ImagesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}
