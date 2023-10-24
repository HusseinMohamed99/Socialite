import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialite/shared/cubit/loginCubit/login_state.dart';
import 'package:socialite/shared/network/cache_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    debugPrint('Done');
    emit(LoginLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffix = IconlyBroken.show;
  bool isPassword = true;
  void changePassword() {
    isPassword = !isPassword;
    suffix = isPassword ? IconlyBroken.show : IconlyBroken.hide;
    emit(ShowPasswordState());
  }

  bool isEmailVerified = false;
  Future<void> loginReloadUser() async {
    emit(LoginReloadLoadingState());
    await FirebaseAuth.instance.currentUser!.reload().then((value) {
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        isEmailVerified = true;
      }
      emit(LoginReloadSuccessState());
    }).catchError((error) {
      emit(LoginReloadErrorState(error.toString()));
    });
  }

  bool isCheck = false;
  void boxCheck(bool newCheck) async {
    emit(ChangeValueLoadingState());
    if (isCheck == newCheck) return;
    isCheck = newCheck;
    CacheHelper.saveData(key: 'check', value: isCheck).then((value) {
      emit(ChangeValueSuccessState());
    }).catchError((error) {
      emit(ChangeValueErrorState());
    });
  }
}
