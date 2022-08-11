import 'package:f_app/Pages/on-boarding/on-boarding%20screen.dart';
import 'package:f_app/layout/Home/home_layout.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialState.dart';
import 'package:f_app/shared/bloc_observer.dart';
import 'package:f_app/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'shared/Cubit/modeCubit/cubit.dart';
import 'shared/componnetns/constants.dart';
import 'shared/network/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  BlocOverrides.runZoned(
        () {},
    blocObserver: MyBlocObserver(),
  );
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget = const HomeLayout();
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
   Widget startWidget;
  final bool? isDark;

   MyApp({Key? key, this.isDark, required this.startWidget})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()..getUserData()..getPosts()
        ),
        BlocProvider(
          create: (BuildContext context) => ModeCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ModeCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: SplashScreenView(
              navigateRoute: startWidget,
              duration: 5000,
              imageSize: 200,
              imageSrc: 'assets/images/s.png',
              text: 'Social App',
              textType: TextType.ColorizeAnimationText,
              textStyle: const TextStyle(
                fontSize: 40.0,
              ),
              colors: const [
                Colors.red,
                Colors.deepOrange,
                Colors.yellow,
                Colors.redAccent,
              ],
              backgroundColor: ModeCubit.get(context).isDark
                  ? const Color(0xff063750)
                  :Colors.white ,
            ),
          );
        },
      ),
    );
  }
}
