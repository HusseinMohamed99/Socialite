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

  Future<void> isUserExist(
      {required String uId,
      required String name,
      required String phone,
      required String email,
      required String image}) async {
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if (element.id == uId) {
          userExist = true;
        }
      }
      if (userExist == false) {
        createGoogleUser(
            uId: uId, name: name, phone: phone, email: email, image: image);
      } else {
        emit(LoginGoogleUserSuccessState(uId));
      }
    });
  }

  ///START : SignIN With Google
  void signINWithGoogle() async {
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
  void createGoogleUser(
      {required String uId,
      required String name,
      required String phone,
      required String email,
      required String image}) {
    UserModel model = UserModel(
      uId: uId,
      name: name,
      phone: phone,
      email: email,
      cover:
          'https://media.cdnandroid.com/27/54/bb/52/imagen-cartoon-photo-editor-art-filter-2018-1gal.jpg',
      image: image,
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

  Future<void> signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    // userCredential mean data for user that i sign in with it
    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);
    CacheHelper.saveData(
      key: 'uid',
      value: user.user!.uid,
    ); // to save User ID on Cache to go to home directly second time
    UserModel model = UserModel(
      name: user.user!.displayName!,
      email: user.user!.email!,
      uId: user.user!.uid,
      image: user.user!.photoURL!,
      bio: "type your bio here",
      portfolio: "",
      phone: user.user!.phoneNumber!,
      cover: user.user!.photoURL!,
      isEmailVerified: user.user!.emailVerified,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.user!.uid)
        .set(model.toMap())
        .then((value) {
      emit(UserLoginSuccessState());
    });
  }
}
