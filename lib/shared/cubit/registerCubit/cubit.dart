import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sociality/model/user_model.dart';
import 'package:sociality/shared/Cubit/registerCubit/state.dart';
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
      image:
          'https://cdn-icons-png.flaticon.com/512/149/149071.png?w=740&t=st=1678640338~exp=1678640938~hmac=e46c26cecdbc9dea7a4a6d4ad5a8577aff6029704aa4d890caaebf20053dd65d',
      cover:
          'https://img.freepik.com/free-photo/social-media-concept-with-smartphone_52683-100042.jpg?w=996&t=st=1678640460~exp=1678641060~hmac=e1b04894098c1fcab71edce47d62db90e08400fd0be4825f2f064df4fa80387c',
      bio: 'Write a bio...',
      isEmailVerified: false,
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
