import 'package:f_app/Pages/password/forget_Password.dart';
import 'package:f_app/Pages/profile/Edit_profile_screen.dart';
import 'package:f_app/Pages/profile/My_profile_screen.dart';
import 'package:f_app/pages/password/change_password.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialState.dart';
import 'package:f_app/shared/components/components.dart';
import 'package:f_app/shared/components/constants.dart';
import 'package:f_app/shared/cubit/socialCubit/SocialCubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          navigateTo(context, EditProfileScreen());
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                IconlyBroken.profile,
                                size: 50,
                                color: Colors.black,
                              ),
                            ),
                            space(10, 0),
                            Text(
                              'Your Personal info',
                              style: GoogleFonts.roboto(
                                color:
                                    cubit.isLight ? Colors.black : Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              IconlyLight.arrowRight2,
                              color: cubit.isLight ? Colors.blue : Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          navigateTo(context, RestPasswordScreen());
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                IconlyBroken.lock,
                                size: 50,
                                color: Colors.black,
                              ),
                            ),
                            space(10, 0),
                            Text(
                              'Rest Password',
                              style: GoogleFonts.roboto(
                                color:
                                    cubit.isLight ? Colors.black : Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              IconlyLight.arrowRight2,
                              color: cubit.isLight ? Colors.blue : Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          navigateTo(context, const EditPasswordScreen());
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                IconlyBroken.unlock,
                                size: 50,
                                color: Colors.black,
                              ),
                            ),
                            space(10, 0),
                            Text(
                              'Change Password',
                              style: GoogleFonts.roboto(
                                color:
                                    cubit.isLight ? Colors.black : Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              IconlyLight.arrowRight2,
                              color: cubit.isLight ? Colors.blue : Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Alert(
                            style: AlertStyle(
                              animationType: AnimationType.shrink,
                              animationDuration:
                                  const Duration(milliseconds: 2000),
                              backgroundColor: cubit.isLight
                                  ? const Color(0xff063750)
                                  : Colors.white,
                              isCloseButton: false,
                              titleStyle: GoogleFonts.roboto(
                                color:
                                    cubit.isLight ? Colors.white : Colors.black,
                              ),
                              descStyle: GoogleFonts.roboto(
                                color:
                                    cubit.isLight ? Colors.white : Colors.black,
                              ),
                            ),
                            padding: EdgeInsets.zero,
                            image: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Image(
                                  height: 200,
                                  width: 500,
                                  fit: BoxFit.fill,
                                  image: cubit.isLight
                                      ? const NetworkImage(
                                          'https://img.freepik.com/free-photo/sunset-sea-with-boat_1048-4663.jpg?w=1380&t=st=1659993560~exp=1659994160~hmac=d0f989119865cff1b42bd569abad29f8bf6c4fb8e96d39bad12c7e0395e956de')
                                      : const NetworkImage(
                                          'https://img.freepik.com/free-photo/beautiful-landscape-sea-ocean-leisure-travel-vacation_74190-8013.jpg?w=996&t=st=1659993461~exp=1659994061~hmac=60ab6a480487329ba91625137fdf6705f5e34600a7cd3af37d866326bec91290'),
                                ),
                                IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(
                                    IconlyBold.closeSquare,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            context: context,
                            title: "Theme Mode",
                            desc: "Do you want change mode.",
                            buttons: [
                              DialogButton(
                                onPressed: () => Navigator.pop(context),
                                color: Colors.red,
                                child: Text(
                                  "Cancel",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              DialogButton(
                                onPressed: () {
                                  cubit.changeMode();
                                  Navigator.pop(context);
                                },
                                color: Colors.blue,
                                child: Text(
                                  "Done",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ).show();
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                cubit.isLight
                                    ? Icons.nightlight_outlined
                                    : Icons.wb_sunny,
                                size: 50,
                                color: Colors.black,
                              ),
                            ),
                            space(10, 0),
                            Text(
                              'Theme Mode',
                              style: GoogleFonts.roboto(
                                color:
                                    cubit.isLight ? Colors.black : Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              IconlyLight.arrowRight2,
                              color: cubit.isLight ? Colors.blue : Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Alert(
                            style: AlertStyle(
                              animationType: AnimationType.shrink,
                              animationDuration:
                                  const Duration(milliseconds: 2000),
                              backgroundColor: cubit.isLight
                                  ? const Color(0xff063750)
                                  : Colors.white,
                              isCloseButton: false,
                              titleStyle: GoogleFonts.roboto(
                                color:
                                    cubit.isLight ? Colors.white : Colors.black,
                              ),
                              descStyle: GoogleFonts.roboto(
                                color:
                                    cubit.isLight ? Colors.white : Colors.black,
                              ),
                            ),
                            padding: EdgeInsets.zero,
                            image: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Image(
                                  height: 200,
                                  width: 500,
                                  fit: BoxFit.fill,
                                  image: cubit.isLight
                                      ? const NetworkImage(
                                          'https://img.freepik.com/premium-vector/blocked-account-conceptual-design-premium-vector_199064-108.jpg?w=740')
                                      : const NetworkImage(
                                          'https://img.freepik.com/premium-vector/blocked-account-conceptual-design-premium-vector_199064-109.jpg?w=740'),
                                ),
                                IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(
                                    IconlyBold.closeSquare,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            context: context,
                            desc: "Do you want Delete Account.",
                            buttons: [
                              DialogButton(
                                onPressed: () => Navigator.pop(context),
                                color: Colors.red,
                                child: Text(
                                  "Cancel",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              DialogButton(
                                onPressed: () {
                                  cubit.deleteAccount(context);
                                  Navigator.pop(context);
                                },
                                color: Colors.blue,
                                child: Text(
                                  "Done",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ).show();
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                IconlyBroken.delete,
                                size: 50,
                                color: Colors.black,
                              ),
                            ),
                            space(10, 0),
                            Text(
                              'Delete your Account',
                              style: GoogleFonts.roboto(
                                color:
                                    cubit.isLight ? Colors.black : Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              IconlyLight.arrowRight2,
                              color: cubit.isLight ? Colors.blue : Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          logOut(context);
                          FirebaseAuth.instance.signOut();
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.power_settings_new_rounded,
                                size: 50,
                                color: Colors.black,
                              ),
                            ),
                            space(10, 0),
                            Text(
                              'LogOut',
                              style: GoogleFonts.roboto(
                                color:
                                    cubit.isLight ? Colors.black : Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              IconlyLight.arrowRight2,
                              color: cubit.isLight ? Colors.blue : Colors.white,
                            )
                          ],
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
    );
  }
}
