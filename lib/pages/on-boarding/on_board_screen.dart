import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialite/Pages/Login/login_screen.dart';
import 'package:socialite/Pages/Register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:socialite/image_assets.dart';
import 'package:socialite/shared/components/buttons.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/loginCubit/login_cubit.dart';
import 'package:socialite/shared/cubit/loginCubit/login_state.dart';
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
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
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
              height: screenHeight,
              width: screenWidth,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.imagesBackground),
                  fit: BoxFit.fill,
                ),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 3,
                        child: Text(
                          AppString.onBoardingBody,
                          textAlign: TextAlign.start,
                          style: textTheme.headlineLarge,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              defaultMaterialButton(
                                function: () {
                                  submit();
                                },
                                text: AppString.signIn,
                                context: context,
                                textColor: ColorManager.blackColor,
                              ),
                              const SizedBox(height: 10),
                              defaultMaterialButton(
                                function: () {
                                  submitted();
                                },
                                text: AppString.signUp,
                                textColor: ColorManager.blackColor,
                                context: context,
                                color: ColorManager.yellowColor,
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
