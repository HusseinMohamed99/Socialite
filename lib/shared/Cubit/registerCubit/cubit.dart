import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_app/model/user_model.dart';
import 'package:f_app/shared/Cubit/registerCubit/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

void userRegister({
  required String email,
  required String password,
  required String phone,
  required String name,
})async {
  debugPrint('Done');
  emit(RegisterLoadingState());
FirebaseAuth.instance.createUserWithEmailAndPassword(
  email: email,
  password: password,
).then((value) 
{
  userCreate(
      email: email,
      phone: phone,
      name: name,
      uId: value.user!.uid
  );
}).catchError((error)
{
  emit(RegisterErrorState(error.toString()));
});
}

void userCreate({
  required String email,
  required String phone,
  required String name,
  required String uId,
})
 async{
  UserModel model = UserModel(
    email: email,
    phone: phone,
    name: name,
    uId: uId,
    image: 'https://img.freepik.com/free-vector/personal-account-positive-feedback-user-review-loyalty-stars-dating-site-website-ranking-woman-evaluating-web-page-cartoon-character_335657-2335.jpg?w=740&t=st=1659975069~exp=1659975669~hmac=57980aa3751376b0cd6408e00c740ba344870a71d3c327b302f1f884ce483661',
    cover: 'https://img.freepik.com/free-vector/happy-man-online-dating-via-laptop_74855-7495.jpg?w=740&t=st=1659974983~exp=1659975583~hmac=510a0521f3caaf3687914a8b5fa8cda52f57e7df66e5aa3fca1efd4ec284fafb',
    bio: 'Write a bio...',
    isEmailVerified : false,
  );
  FirebaseFirestore.instance
      .collection('users')
      .doc(uId)
      .set(model.toMap())
      .then((value) {
emit(UserCreateSuccessState(uId));
  }).catchError((error)
  {
    emit(UserCreateErrorState(error));
  });
}

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePassword() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordRegisterState());
  }
}
