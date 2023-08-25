import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociality/shared/components/buttons.dart';
import 'package:sociality/shared/components/text_form_field.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/styles/color.dart';

void bottomSheetChangePassword(
    {required BuildContext context, required SocialCubit cubit}) {
  showModalBottomSheet(
    backgroundColor: cubit.isDark
        ? AppMainColors.titanWithColor
        : AppColorsDark.primaryDarkColor,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ).r,
    ),
    context: context,
    builder: (context) {
      return const ShowModalBottomSheet();
    },
  );
}

class ShowModalBottomSheet extends StatelessWidget {
  const ShowModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    SocialCubit cubit = SocialCubit.get(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.35.sp,
      minChildSize: 0.35.spMin,
      maxChildSize: 0.5.spMax,
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            decoration: BoxDecoration(
              color: cubit.isDark
                  ? AppMainColors.whiteColor
                  : AppColorsDark.primaryDarkColor,
              borderRadius:
                  BorderRadius.vertical(top: const Radius.circular(20).r),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10).r,
            margin: const EdgeInsets.symmetric(horizontal: 10).r,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -20.h,
                  child: Container(
                    width: 50.w,
                    height: 6.h,
                    margin: const EdgeInsets.only(bottom: 20).r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.5).r,
                      color: AppMainColors.mainColor,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        'Change Password',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 25,
                          bottom: 25,
                        ).r,
                        child: Column(
                          children: [
                            DefaultTextFormField(
                              controller: currentPasswordController,
                              keyboardType: TextInputType.visiblePassword,
                              validate: (String? value) {
                                if (value!.trim().isEmpty) {
                                  return 'Please enter your current password';
                                }
                                return null;
                              },
                              label: 'Current Password',
                              prefix: IconlyBroken.unlock,
                              suffix: cubit.suffix,
                              suffixPressed: () {
                                cubit.showPassword();
                              },
                              isPassword: cubit.isPassword,
                            ),
                            SizedBox(height: 20.h),
                            DefaultTextFormField(
                              controller: newPasswordController,
                              keyboardType: TextInputType.visiblePassword,
                              validate: (String? value) {
                                if (value!.trim().isEmpty) {
                                  return 'Please enter your new password';
                                } else if (value.length < 8) {
                                  return 'Password is too short';
                                }
                                return null;
                              },
                              label: 'New Password',
                              prefix: IconlyBroken.unlock,
                              suffix: cubit.suffixIcon,
                              suffixPressed: () {
                                cubit.showConfirmPassword();
                              },
                              isPassword: cubit.iSPassword,
                            ),
                            SizedBox(height: 20.h),
                            defaultTextButton(
                              context: context,
                              text: 'Change Password',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.changeUserPassword(
                                    newPassword: newPasswordController.text,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
