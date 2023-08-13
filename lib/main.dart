import 'package:sociality/firebase_options.dart';
import 'package:sociality/pages/splash/splash_screen.dart';
import 'package:sociality/shared/Cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/Cubit/socialCubit/social_state.dart';
import 'package:sociality/shared/bloc_observer.dart';
import 'package:sociality/shared/components/components.dart';
import 'package:sociality/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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


  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();
  bool? isLight = CacheHelper.getBoolean(key: 'isLight');
  uId = CacheHelper.getData(key: 'uId');
  debugPrint('*** User ID == $uId ***');

  runApp(
    MyApp(
      isLight: isLight,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool? isLight;

  const MyApp({
    Key? key,
    this.isLight,
  }) : super(key: key);

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
            ..changeMode(
              fromShared: isLight,
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
                debugShowCheckedModeBanner: false,
                theme: ThemeApp.lightTheme,
                darkTheme: ThemeApp.darkTheme,
                themeMode: SocialCubit.get(context).isLight
                    ? ThemeMode.light
                    : ThemeMode.dark,
                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
