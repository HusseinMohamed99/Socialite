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
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  void submit() {
    CacheHelper.saveData(
      key: AppString.onBoarding,
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
      key: AppString.onBoarding,
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
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            ),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.imagesBack),
                  fit: BoxFit.fill,
                ),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          AppString.onBoardingBody,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              color: ColorManager.titanWithColor,
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
                                  color: ColorManager.whiteColor,
                                  borderRadius: BorderRadius.circular(10.0).r,
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    submit();
                                  },
                                  child: Text(
                                    AppString.signIn.toUpperCase(),
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
                                  color: ColorManager.yellowColor,
                                  borderRadius: BorderRadius.circular(10.0).r,
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    submitted();
                                  },
                                  child: Text(
                                    AppString.signUp.toUpperCase(),
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
                                  color: ColorManager.titanWithColor,
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
                                            SvgPicture.asset(
                                                Assets.imagesGoogle),
                                            Text(
                                              AppString.signInWithGoogle
                                                  .toUpperCase(),
                                              style:
                                                  GoogleFonts.robotoCondensed(
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
            ),
          );
        },
      ),
    );
  }
}
