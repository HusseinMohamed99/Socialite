import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialite/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialite/shared/cubit/registerCubit/state.dart';
import 'package:socialite/shared/network/cache_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) async {
    debugPrint('Done');
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(email: email, phone: phone, name: name, uId: value.user!.uid);
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String phone,
    required String name,
    required String uId,
  }) async {
    UserModel model = UserModel(
      email: email,
      phone: phone,
      name: name,
      uId: uId,
      image:
          'https://img.freepik.com/free-vector/mysterious-mafia-man-smoking-cigarette_52683-34828.jpg?w=740&t=st=1692497461~exp=1692498061~hmac=4e76f888ce2372f12e339835e14f04b559236b4ae063439961923a24133f274b',
      cover:
          'https://img.freepik.com/free-photo/islamic-new-year-decoration-with-lantern-quran_23-2148950335.jpg?w=900&t=st=1692497617~exp=1692498217~hmac=8a5078eef18cdaff2a1fe98110abc0f964ac1ba439b08056171561ae7c7a1046',
      bio: 'Write a bio...',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(UserCreateSuccessState(uId));
    }).catchError((error) {
      emit(UserCreateErrorState(error));
    });
  }

  IconData suffixIcon = IconlyBroken.show;
  bool isPassword = true;
  void changePassword() {
    isPassword = !isPassword;
    suffixIcon = isPassword ? IconlyBroken.show : IconlyBroken.hide;

    emit(ChangePasswordRegisterState());
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
