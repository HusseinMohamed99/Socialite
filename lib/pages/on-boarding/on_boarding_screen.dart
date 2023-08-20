import 'package:flutter/services.dart';
import 'package:sociality/Pages/Login/login_screen.dart';
import 'package:sociality/Pages/Register/register_screen.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/network/cache_helper.dart';
import 'package:sociality/shared/styles/color.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        navigateTo(
          context,
          const LoginScreen(),
        );
      }
    });
  }

  void submitted() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        navigateTo(
          context,
          const RegisterScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/back.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Expanded(
                child: Text(
                  'Snap\nand\nShare\nevery\nmoments',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 60.sp,
                      overflow: TextOverflow.visible,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Expanded(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 270.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: AppMainColors.whiteColor,
                          borderRadius: BorderRadius.circular(10.0).r,
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            submit();
                          },
                          child: Text(
                            'Sign in'.toUpperCase(),
                            style: GoogleFonts.robotoCondensed(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      space(0, 20.h),
                      Container(
                        width: 270.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: AppMainColors.yellowColor,
                          borderRadius: BorderRadius.circular(10.0).r,
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            submitted();
                          },
                          child: Text(
                            'Sign up'.toUpperCase(),
                            style: GoogleFonts.robotoCondensed(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      space(0, 50.h),
                    ],
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
