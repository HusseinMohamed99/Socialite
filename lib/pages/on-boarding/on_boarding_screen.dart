import 'package:sociality/Pages/Login/login_screen.dart';
import 'package:sociality/Pages/Register/register_screen.dart';
import 'package:sociality/shared/components/components.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sociality/shared/styles/color.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

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
                            navigateAndFinish(context, const LoginScreen());
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
                            navigateTo(context, const RegisterScreen());
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
