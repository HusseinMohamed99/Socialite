import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialite/Pages/Login/login_screen.dart';
import 'package:socialite/Pages/Register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialite/image_assets.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/loginCubit/cubit.dart';
import 'package:socialite/shared/cubit/loginCubit/state.dart';
import 'package:socialite/shared/network/cache_helper.dart';
import 'package:socialite/shared/styles/color.dart';

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
    return BlocProvider(
      create: (BuildContext context) {
        return LoginCubit();
      },
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.imagesBack),
                fit: BoxFit.fitHeight,
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
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Snap\nAnd\nShare\nEvery\nMoments',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: AppMainColors.titanWithColor,
                            fontSize: 60.sp,
                            overflow: TextOverflow.visible,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 40.h,
                              width: 300.w,
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
                            SizedBox(height: 10.h),
                            Container(
                              height: 40.h,
                              width: 300.w,
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
                            SizedBox(height: 10.h),
                            Container(
                              height: 40.h,
                              width: 300.w,
                              decoration: BoxDecoration(
                                color: AppMainColors.titanWithColor,
                                borderRadius: BorderRadius.circular(10.0).r,
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  LoginCubit.get(context)
                                      .getGoogleUserCredentials();
                                },
                                child: state is LoginGoogleUserLoadingState
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SvgPicture.asset(Assets.imagesGoogle),
                                          Text(
                                            'Sign In With Google '
                                                .toUpperCase(),
                                            style: GoogleFonts.robotoCondensed(
                                              textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
