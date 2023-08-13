import 'package:sociality/layout/Home/home_layout.dart';
import 'package:sociality/pages/on-boarding/on_boarding_screen.dart';
import 'package:sociality/shared/Cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/components/components.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:sociality/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = 'splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SplashScreenBody(),
    );
  }
}

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({Key? key}) : super(key: key);

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? fadingAnimation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    fadingAnimation =
        Tween<double>(begin: 0.1, end: 1).animate(animationController!);

    animationController?.repeat(reverse: true);

    goToNextView();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SocialCubit.get(context).isLight
          ? Colors.transparent
          : ThemeApp.darkPrimary,
      appBar: defaultAppBar(),
      body: FadeTransition(
        opacity: fadingAnimation!,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      SocialCubit.get(context).isLight
                          ? 'assets/images/sLight.png'
                          : 'assets/images/sDark.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sociality',
                    style: GoogleFonts.pacifico(
                      textStyle: TextStyle(
                        color: SocialCubit.get(context).isLight
                            ? Colors.blue
                            : Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    'APP',
                    style: GoogleFonts.pacifico(
                      textStyle: TextStyle(
                        color: SocialCubit.get(context).isLight
                            ? Colors.blue
                            : Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goToNextView() {
    Widget widget;
    Future.delayed(const Duration(seconds: 2), () {

      if (uId != null) {
        widget = const HomeLayout();
      } else {
        widget = const OnBoard();
      }
      navigateAndFinish(context, widget);
    });
  }
}