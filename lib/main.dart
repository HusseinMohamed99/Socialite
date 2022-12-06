import 'package:f_app/Pages/on-boarding/on-boarding%20screen.dart';
import 'package:f_app/desktop/desktop_screen.dart';
import 'package:f_app/layout/Home/home_layout.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialState.dart';
import 'package:f_app/shared/bloc_observer.dart';
import 'package:f_app/shared/components/components.dart';
import 'package:f_app/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'shared/components/constants.dart';
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


  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();
  bool? isLight = CacheHelper.getBoolean(key: 'isLight');
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget =  const HomeLayout();
  } else {
    widget = const OnBoard();
  }

  debugPrint('*** User ID == $uId ***');
  runApp(MultiBlocProvider(
    providers:  [
      BlocProvider(
          create: (context) => SocialCubit()
            ..getUserData()
            ..getPosts()
            ..getAllUsers()
            ..getStories()
            ..changeMode(fromShared: isLight,)
      ),
    ],
      child: BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return MyApp(
          isLight: isLight,
          startWidget: widget,
        );
      },

  ),),);

}

class MyApp extends StatelessWidget {
  final  Widget startWidget;
  final bool? isLight;

   const MyApp({Key? key, this.isLight, required this.startWidget})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: SocialCubit.get(context).isLight
              ? ThemeMode.light
              : ThemeMode.dark,
          home: LayoutBuilder(
              builder: (BuildContext context,BoxConstraints constraints)
              {
                if (kDebugMode) {
                  print(constraints.minWidth.toInt());
                }
                if (constraints.minWidth.toInt() <=560) {
                  return  SplashScreenView(
                    duration: 3500,
                    pageRouteTransition: PageRouteTransition.Normal,
                    navigateRoute: startWidget,
                    imageSize: 200,
                    imageSrc: SocialCubit.get(context).isLight
                        ?'assets/images/sLight.png'
                        :'assets/images/sDark.png',
                    text: 'F-APP',
                    textType: TextType.ColorizeAnimationText,
                    textStyle: GoogleFonts.libreBaskerville(
                        fontSize: 50,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 10
                    ),
                    colors:  [
                      SocialCubit.get(context).isLight
                          ? Colors.black
                          : Colors.white ,
                      Colors.deepOrangeAccent,
                      Colors.redAccent,
                      Colors.green,
                    ],
                    backgroundColor: SocialCubit.get(context).isLight
                        ?  Colors.white
                        : const Color(0xff404258),
                  );
                }
                return const DesktopScreen();


              }


          ),



        );


  }
}




