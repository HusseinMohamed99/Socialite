import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialite/Pages/Login/login_screen.dart';
import 'package:socialite/image_assets.dart';
import 'package:socialite/shared/components/indicator.dart';
import 'package:socialite/shared/components/show_toast.dart';
import 'package:socialite/shared/cubit/restPasswordCubit/rest_password_cubit.dart';
import 'package:socialite/shared/cubit/restPasswordCubit/rest_password_state.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/components/text_form_field.dart';
import 'package:socialite/shared/utils/color_manager.dart';

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
            showToast(text: 'Check your mail', state: ToastStates.success);
            navigateAndFinish(context, const LoginScreen());
          }
        },
        builder: (context, state) {
          SocialCubit cubit = SocialCubit.get(context);
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 1,
              leading: IconButton(
                icon: Icon(
                  IconlyBroken.arrowLeft2,
                  size: 30.sp,
                  color: cubit.isDark
                      ? ColorManager.blackColor
                      : ColorManager.titanWithColor,
                ),
                onPressed: () {
                  emailController.clear();
                  Navigator.pop(context);
                },
              ),
              titleSpacing: 1,
              title: Text(
                'Forget Password',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage(Assets.imagesResetPassword),
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
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 150.h,
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          left: 15,
                          top: 20,
                          right: 15,
                          bottom: 0,
                        ).r,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurStyle: BlurStyle.outer,
                              color: ColorManager.greenColor,
                              blurRadius: 9,
                              spreadRadius: 10.r,
                              offset: const Offset(0, 1),
                            )
                          ],
                          border: Border.all(color: ColorManager.dividerColor),
                          color: cubit.isDark
                              ? ColorManager.titanWithColor
                              : ColorManager.greyDarkColor,
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
                              SizedBox(height: 10.h),
                              DefaultTextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                prefix: IconlyBroken.message,
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
                                  ? const Center(
                                      child: AdaptiveIndicator(),
                                    )
                                  : defaultTextButton(
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
