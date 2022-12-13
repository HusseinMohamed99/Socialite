import 'package:f_app/desktop/desktop_screen.dart';
import 'package:f_app/firebase_options.dart';
import 'package:f_app/pages/splash/splash_screen.dart';
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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'shared/components/constants.dart';
import 'shared/network/cache_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{  showToast(text: 'Messaging Background', state: ToastStates.success);
  debugPrint('background');
  debugPrint(message.data.toString());

}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  uId = CacheHelper.getData(key: 'uId');
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
         // startWidget: widget,
        );
      },

  ),),);

}

class MyApp extends StatelessWidget {
//  final  Widget startWidget;
  final bool? isLight;

   const MyApp({Key? key, this.isLight,})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        return MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate, // Add this line
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,

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
                  return  const SplashScreen();
                }
                return const DesktopScreen();
              }
          ),
        );
  }
}




