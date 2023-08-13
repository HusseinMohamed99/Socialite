import 'package:sociality/Pages/Login/login_screen.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/network/cache_helper.dart';

void logOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      navigateAndFinish(context, const LoginScreen());
    }
  });
}