import 'package:f_app/Pages/on-boarding/on-boarding%20screen.dart';
import 'package:f_app/layout/Home/home_layout.dart';
import 'package:f_app/shared/Cubit/modeCubit/cubit.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialState.dart';
import 'package:f_app/shared/bloc_observer.dart';
import 'package:f_app/shared/componnetns/components.dart';
import 'package:f_app/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'shared/componnetns/constants.dart';
import 'shared/network/cache_helper.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{  showToast(text: 'Messaging Background', state: ToastStates.success);
  debugPrint('background');
  debugPrint(message.data.toString());

}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //when the app is opened
  FirebaseMessaging.onMessage.listen((event)
  {   showToast(text: 'on Message', state: ToastStates.success);
    debugPrint('when the app is opened');
    debugPrint(event.data.toString());

  });
  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event)
  { showToast(text: 'on Message Opened App', state: ToastStates.success);
    debugPrint('when click on notification to open app');
    debugPrint(event.data.toString());

  });
  // background notification
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);


  BlocOverrides.runZoned(
        () {},
    blocObserver: MyBlocObserver(),
  );
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget =  const HomeLayout();
  } else {
    widget = const OnBoard();
  }

  debugPrint(uId);
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final  Widget startWidget;
  final bool? isDark;

   const MyApp({Key? key, this.isDark, required this.startWidget})
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

        ),
        BlocProvider(
            create: (context) => ModeCubit()
              ..changeAppMode(fromShared: isDark,)

        ),


      ],

      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ModeCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: SplashScreenView(
              duration: 3500,
              pageRouteTransition: PageRouteTransition.Normal,
              navigateRoute: startWidget,
              imageSize: 200,
              imageSrc: 'assets/images/s.png',
              text: 'F-APP',
              textType: TextType.ColorizeAnimationText,
              textStyle: GoogleFonts.libreBaskerville(
                fontSize: 50,
                fontWeight: FontWeight.w700,
                letterSpacing: 10
              ),
              colors:  [
                ModeCubit.get(context).isDark
                    ? Colors.white
                    : Colors.black ,
                Colors.deepOrangeAccent,
                Colors.redAccent,
                Colors.green,
              ],
              backgroundColor: ModeCubit.get(context).isDark
                  ? const Color(0xff063750)
                  : Colors.white,
            ),
          );
        },
      ),
    );
  }
}
