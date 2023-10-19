import 'package:flutter/foundation.dart';
import 'package:socialite/firebase_options.dart';
import 'package:socialite/layout/Home/home_layout.dart';
import 'package:socialite/pages/Home/home_page.dart';
import 'package:socialite/pages/on-boarding/on_boarding_screen.dart';
import 'package:socialite/shared/components/show_toast.dart';
import 'package:socialite/shared/cubit/Internet/internet_bloc.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:socialite/shared/bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/shared/enum/enum.dart';
import 'package:socialite/shared/network/dio_helper.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/themes.dart';
import 'shared/components/constants.dart';
import 'shared/network/cache_helper.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  showToast(text: AppString.receivedMessage, state: ToastStates.success);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (kDebugMode) {
    print('${AppString.authorizationStatus}: ${settings.authorizationStatus}');
  }
  ScreenUtil.ensureScreenSize();

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  //when the app is opened
  FirebaseMessaging.onMessage.listen((event) {
    showToast(text: AppString.receivedMessage, state: ToastStates.success);
  });
  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    showToast(text: AppString.openedApp, state: ToastStates.success);
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  bool? isDark = CacheHelper.getBoolean(key: AppString.isDark);
  uId = CacheHelper.getData(key: AppString.uId);
  debugPrint('*** User ID == $uId ***');

  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: AppString.onBoarding);

  if (onBoarding != null) {
    if (uId != null) {
      widget = const HomeLayout();
    } else {
      widget = const HomePage();
    }
  } else {
    widget = const OnBoardingScreen();
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
            ..getPosts()
            ..getStories()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
          create: (context) => InternetCubit(),
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
                title: AppString.appTitle,
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
