import 'package:sociality/firebase_options.dart';
import 'package:sociality/layout/Home/home_layout.dart';
import 'package:sociality/pages/Login/login_screen.dart';
import 'package:sociality/pages/on-boarding/on_boarding_screen.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/cubit/socialCubit/social_state.dart';
import 'package:sociality/shared/bloc_observer.dart';
import 'package:sociality/shared/components/components.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociality/shared/enum/enum.dart';
import 'package:sociality/shared/network/dio_helper.dart';
import 'package:sociality/shared/styles/themes.dart';
import 'package:wakelock/wakelock.dart';
import 'shared/components/constants.dart';
import 'shared/network/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ScreenUtil.ensureScreenSize();
  Wakelock.enable();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  //when the app is opened
  FirebaseMessaging.onMessage.listen((event) {
    showToast(text: 'on Message', state: ToastStates.success);
    debugPrint('when the app is opened');
    debugPrint(event.data.toString());
  });
  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    showToast(text: 'on Message Opened App', state: ToastStates.success);
    debugPrint('when click on notification to open app');
    debugPrint(event.data.toString());
  });

  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  uId = CacheHelper.getData(key: 'uId');
  debugPrint('*** User ID == $uId ***');
  Widget widget;

  if (OnBoard != null) {
    if (uId != null) {
      widget = const HomeLayout();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoard();
  }
  runApp(
    MyApp(
      startWidget: widget,
      isDark: isDark,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget startWidget;

  const MyApp({Key? key, required this.startWidget, this.isDark})
      : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()
            ..getUserData()
            ..getPosts()
            ..getAllUsers()
            ..getStories()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                title: 'Sociality',
                theme: getThemeData[AppTheme.lightTheme],
                darkTheme: getThemeData[AppTheme.darkTheme],
                themeMode: uId == null
                    ? ThemeMode.system
                    : SocialCubit.get(context).isDark
                        ? ThemeMode.light
                        : ThemeMode.dark,
                debugShowCheckedModeBanner: false,
                home: startWidget,
              );
            },
          );
        },
      ),
    );
  }
}
