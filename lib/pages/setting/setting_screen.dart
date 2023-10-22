import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:socialite/pages/password/change_password.dart';
import 'package:socialite/pages/password/forget_password.dart';
import 'package:socialite/pages/profile/edit_profile_screen.dart';
import 'package:socialite/pages/profile/user_profile_screen.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/components/logout.dart';
import 'package:socialite/shared/components/my_divider.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';
import 'package:socialite/shared/widget/settings_list.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel!;
        SocialCubit cubit = SocialCubit.get(context);
        return ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(AppPadding.p8),
          children: [
            GestureDetector(
              onTap: () {
                SocialCubit.get(context).getUserPosts(uId);
                SocialCubit.get(context).getFriends(uId!);
                navigateTo(context, const UserProfileScreen());
              },
              child: Card(
                color: cubit.isDark
                    ? ColorManager.titanWithColor
                    : ColorManager.blackColor.withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        child: ImageWithShimmer(
                          imageUrl: userModel.image,
                          width: 50,
                          height: 50,
                          radius: 15,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userModel.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              AppString.seeProfile,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            InkWell(
                              onTap: () {
                                urlLauncher(
                                  Uri.parse(userModel.portfolio),
                                );
                              },
                              child: Text(
                                userModel.portfolio,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: ColorManager.blueColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        IconlyBroken.arrowRight2,
                        color: ColorManager.greyColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              AppString.account,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const MyDivider(vertical: AppMargin.m12),
            SettingsListItem(
              cubit: cubit,
              iconData: IconlyBroken.profile,
              text: AppString.personalInfo,
              function: () {
                navigateTo(context, const EditProfileScreen());
              },
            ),
            SettingsListItem(
              cubit: cubit,
              iconData: IconlyBroken.lock,
              text: AppString.resetPassword,
              function: () {
                navigateTo(context, const ResetPasswordScreen());
              },
            ),
            SettingsListItem(
              cubit: cubit,
              iconData: IconlyBroken.unlock,
              text: AppString.changePassword,
              function: () {
                bottomSheetChangePassword(
                  context: context,
                  cubit: cubit,
                );
              },
            ),
            SettingsListItem(
              cubit: cubit,
              iconData:
                  cubit.isDark ? Icons.nightlight_outlined : Icons.wb_sunny,
              text: AppString.themeMode,
              function: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.question,
                  animType: AnimType.topSlide,
                  title: AppString.changeMode,
                  btnOkOnPress: () {
                    cubit.changeAppMode();
                  },
                  btnCancelOnPress: () {},
                ).show();
              },
            ),
            SettingsListItem(
              cubit: cubit,
              iconData: IconlyBroken.delete,
              text: AppString.deleteAccount,
              function: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.topSlide,
                  title: AppString.wantDeleteAccount,
                  btnOkOnPress: () {
                    cubit.deleteAccount(context);
                  },
                  btnCancelOnPress: () {},
                ).show();
              },
            ),
            SettingsListItem(
              cubit: cubit,
              iconData: Icons.power_settings_new_rounded,
              text: AppString.logout,
              function: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.topSlide,
                  title: AppString.wantLogout,
                  btnOkOnPress: () {
                    logOut(context);
                    FirebaseAuth.instance.signOut();
                  },
                  btnCancelOnPress: () {},
                ).show();
              },
            ),
            const SizedBox(height: 50),
          ],
        );
      },
    );
  }
}
