import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
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
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/my_validators.dart';
import 'package:socialite/shared/utils/value_manager.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final nameFocusNode = FocusNode();
    final phoneFocusNode = FocusNode();
    final passwordFocusNode = FocusNode();
    final emailFocusNode = FocusNode();
    final formKey = GlobalKey<FormState>();

    TextTheme textTheme = Theme.of(context).textTheme;
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
              const ImagesWidget(),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(AppPadding.p16),
                  decoration: BoxDecoration(
                    color: SocialCubit.get(context).isDark
                        ? ColorManager.titanWithColor
                        : ColorManager.blackColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ).r,
                  ),
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: RegisterWidget(
                      textTheme: textTheme,
                      emailController: emailController,
                      nameController: nameController,
                      phoneController: phoneController,
                      emailFocusNode: emailFocusNode,
                      passwordFocusNode: passwordFocusNode,
                      passwordController: passwordController,
                      formKey: formKey,
                      phoneFocusNode: phoneFocusNode,
                      nameFocusNode: nameFocusNode,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
            child: SvgPicture.asset(Assets.imagesGroup1320),
          ),
          Expanded(
            flex: 2,
            child: SvgPicture.asset(Assets.imagesAchievement),
          ),
        ],
      ),
    );
  }
}

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({
    super.key,
    required this.textTheme,
    required this.emailController,
    required this.nameController,
    required this.phoneController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.passwordController,
    required this.formKey,
    required this.phoneFocusNode,
    required this.nameFocusNode,
  });

  final TextTheme textTheme;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode phoneFocusNode;
  final FocusNode nameFocusNode;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is UserCreateSuccessState) {
            CacheHelper.saveData(value: state.uid, key: AppString.uId)
                .then((value) {
              uId = state.uid;
              navigateAndFinish(
                context,
                const EmailVerificationScreen(),
              );
            });
          }
          if (state is UserCreateErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.error,
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Text(
                AppString.signUpNow,
                style: textTheme.displayLarge,
              ),
              SizedBox(height: 10.h),
              Text(
                AppString.yourInformation,
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 20.h),
              CustomTextFormField(
                controller: nameController,
                textInputType: TextInputType.name,
                prefixIcon: IconlyBroken.user2,
                validator: (String? value) {
                  return MyValidators.displayNameValidator(value);
                },
                hintText: AppString.name,
                focusNode: emailFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(emailFocusNode);
                },
              ),
              SizedBox(height: 15.h),
              CustomTextFormField(
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                prefixIcon: IconlyBroken.message,
                validator: (String? value) {
                  return MyValidators.emailValidator(value);
                },
                hintText: AppString.email,
                focusNode: emailFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(phoneFocusNode);
                },
              ),
              SizedBox(height: 15.h),
              CustomTextFormField(
                controller: phoneController,
                textInputType: TextInputType.phone,
                prefixIcon: IconlyBroken.call,
                validator: (String? value) {
                  return MyValidators.phoneValidator(value);
                },
                hintText: AppString.phone,
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
                prefixIcon: IconlyBroken.password,
                suffixIcon: RegisterCubit.get(context).suffixIcon,
                obscureText: RegisterCubit.get(context).isPassword,
                suffixIconOnTap: () {
                  RegisterCubit.get(context).changePassword();
                },
                validator: (value) {
                  return MyValidators.passwordValidator(value);
                },
                hintText: AppString.password,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {},
              ),
              SizedBox(height: 15.h),
              RegisterCubit.get(context).isCheck
                  ? ConditionalBuilder(
                      condition: state is! RegisterLoadingState,
                      builder: (context) {
                        return defaultMaterialButton(
                          color: ColorManager.mainColor,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                                name: nameController.text,
                              );
                            }
                          },
                          text: AppString.signUp,
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
                        AppString.signUp.toUpperCase(),
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
                        ColorManager.greyColor,
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
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
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
                      navigateTo(context, const LoginScreen());
                    },
                    text: AppString.signIn.toUpperCase(),
                    color: ColorManager.mainColor,
                    context: context,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget checkBox(BuildContext context, Color? color) {
    var cubit = RegisterCubit.get(context);
    return Checkbox.adaptive(
      side: BorderSide(
        color: color ?? ColorManager.whiteColor,
      ),
      activeColor: ColorManager.mainColor,
      value: cubit.isCheck,
      onChanged: (e) {
        cubit.boxCheck(e!);
      },
    );
  }
}
