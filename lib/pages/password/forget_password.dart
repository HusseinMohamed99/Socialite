import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialite/Pages/Login/login_screen.dart';
import 'package:socialite/image_assets.dart';
import 'package:socialite/shared/components/indicator.dart';
import 'package:socialite/shared/components/show_toast.dart';
import 'package:socialite/shared/cubit/restPasswordCubit/rest_password_cubit.dart';
import 'package:socialite/shared/cubit/restPasswordCubit/rest_password_state.dart';
import 'package:socialite/shared/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/components/text_form_field.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/my_validators.dart';
import 'package:socialite/shared/utils/value_manager.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginFormKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final emailFocusNode = FocusNode();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: BlocProvider(
        create: (context) => ResetPasswordCubit(),
        child: BlocConsumer<ResetPasswordCubit, ResetPasswordStates>(
          listener: (context, state) {
            if (state is ResetPasswordSuccessState) {
              showToast(text: AppString.checkMail, state: ToastStates.success);
              navigateAndFinish(context, const LoginScreen());
            }
          },
          builder: (context, state) {
            TextTheme textTheme = Theme.of(context).textTheme;
            double screenHeight = MediaQuery.sizeOf(context).height;
            return Scaffold(
              backgroundColor: SocialCubit.get(context).isDark
                  ? ColorManager.primaryColor
                  : ColorManager.primaryDarkColor,
              appBar: AppBar(
                elevation: 0,
                title: Text(
                  AppString.forgotPassword,
                  style: textTheme.headlineMedium!
                      .copyWith(color: ColorManager.whiteColor),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      Assets.imagesResetPassword,
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppPadding.p20),
                        child: Text(
                          AppString.mailAssociated,
                          style: textTheme.headlineMedium!
                              .copyWith(color: ColorManager.whiteColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                        child: Container(
                          height: screenHeight * .25,
                          width: double.infinity,
                          padding: const EdgeInsets.all(AppPadding.p20),
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurStyle: BlurStyle.outer,
                                color: ColorManager.greenColor,
                                blurRadius: 9,
                                spreadRadius: 10,
                                offset: Offset(0, 1),
                              )
                            ],
                          ),
                          child: Form(
                            key: loginFormKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextFormField(
                                  prefixIcon: IconlyBroken.message,
                                  controller: emailController,
                                  focusNode: emailFocusNode,
                                  textInputAction: TextInputAction.next,
                                  hintText: AppString.emailAddress,
                                  textInputType: TextInputType.emailAddress,
                                  onFieldSubmitted: (value) {},
                                  validator: (value) {
                                    return MyValidators.emailValidator(value);
                                  },
                                ),
                                const Spacer(),
                                state is ResetPasswordLoadingState
                                    ? const Center(
                                        child: AdaptiveIndicator(),
                                      )
                                    : defaultTextButton(
                                        context: context,
                                        color: ColorManager.blueColor,
                                        text: AppString.resetPassword,
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
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
