import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/shared/cubit/loginCubit/state.dart';
import 'package:socialite/shared/network/cache_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  ///START : Login With E-mail & Password
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

  ///END : Login With E-mail & Password

  ///START : Show Password
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePassword() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShowPasswordState());
  }

  ///END : Show Password

  bool userExist = false;

  Future<void> isUserExist({
    required String uId,
    required String name,
    required String phone,
    required String email,
    required String image,
  }) async {
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if (element.id == uId) {
          userExist = true;
        }
      }
      if (userExist == false) {
        createGoogleUser(
          uId: uId,
          name: name,
          phone: phone,
          email: email,
          image: image,
        );
      } else {
        emit(LoginGoogleUserSuccessState(uId));
      }
    });
  }

  ///START : SignIN With Google
  void getGoogleUserCredentials() async {
    emit(LoginGoogleUserLoadingState());
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      isUserExist(
        uId: value.user!.uid,
        name: value.user!.displayName!,
        phone: value.user!.phoneNumber!,
        email: value.user!.email!,
        image: value.user!.photoURL!,
      );
    });
  }

  ///END : SignIN With Google
  void createGoogleUser({
    required String uId,
    required String name,
    required String? phone,
    required String email,
    required String? image,
  }) {
    UserModel model = UserModel(
      uId: uId,
      name: name,
      phone: phone ?? '0000-000-0000',
      email: email,
      cover:
          'https://img.freepik.com/free-photo/islamic-new-year-decoration-with-lantern-quran_23-2148950335.jpg?w=900&t=st=1692497617~exp=1692498217~hmac=8a5078eef18cdaff2a1fe98110abc0f964ac1ba439b08056171561ae7c7a1046',
      image: image ??
          'https://img.freepik.com/free-vector/mysterious-mafia-man-smoking-cigarette_52683-34828.jpg?w=740&t=st=1692497461~exp=1692498061~hmac=4e76f888ce2372f12e339835e14f04b559236b4ae063439961923a24133f274b',
      bio: 'Write you own bio...',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateGoogleUserSuccessState(uId));
    }).catchError((error) {
      emit(CreateGoogleUserErrorState());
    });
  }

  ///START : isEmailVerified
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

  ///END : isEmailVerified

  bool isCheck = false;

  void boxCheck(bool newCheck) async {
    emit(ChangeValueLoadingState());
    if (isCheck == newCheck) return;
    isCheck = newCheck;
    CacheHelper.saveData(key: 'check', value: isCheck).then((value) {
      emit(ChangeValueSuccessState());
      if (kDebugMode) {
        print('isCheck === $isCheck');
      }
    }).catchError((error) {
      emit(ChangeValueErrorState());
    });
  }
}
