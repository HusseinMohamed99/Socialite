import 'package:f_app/Pages/Login/login_screen.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:f_app/shared/network/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

Widget defaultTextFormField({
 required BuildContext context,
  FocusNode? focusNode,
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String? Function(String?) validate,
  required String? hint,
  onTap,
  onChanged,
  Function(String)? onFieldSubmitted,
  bool isPassword = false,
  bool isClickable = true,
  InputDecoration? decoration,
  IconData? suffix,
  IconData? prefix,
  Function? suffixPressed,  TextStyle? style,}) {
  return TextFormField(
      focusNode: FocusNode(),
      style: GoogleFonts.libreBaskerville(
        color: SocialCubit.get(context).isDark? Colors.black : Colors.white,
      ),
      maxLines: 1,
      minLines: 1,
      controller: controller,
      validator: validate,
      enabled: isClickable,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      obscureText: isPassword,
      keyboardType: keyboardType,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefix,
          color: SocialCubit.get(context).isDark? Colors.grey : Colors.white,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                  color: SocialCubit.get(context).isDark? Colors.grey : Colors.white,
                ),
              )
            : null,
        focusedBorder:  OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            color: SocialCubit.get(context).isDark? Colors.black : Colors.white,
          ),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: SocialCubit.get(context).isDark? Colors.black : Colors.white,
        ),
        enabledBorder:  OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            color: SocialCubit.get(context).isDark? Colors.black : Colors.white,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
}

Widget defaultMaterialButton({
  required Function() function,
  required String text,
  double width = 300,
  double height = 45.0,
  double radius = 10.0,
  bool isUpperCase = true,
  Function? onTap,}) =>
   Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: HexColor('#4e67dd'),
        //  color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );


Widget defaultTextButton({
  required Function function,
  required String text,
required BuildContext context
}) {
  return TextButton(
      onPressed: () {
        function();
      },
      child: Text(text,style: GoogleFonts.libreBaskerville(
        fontWeight: FontWeight.w400,
        color:
        SocialCubit.get(context).isDark ? Colors.white : Colors.black,
      ),),
    );
}

Widget myDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
      width: double.infinity,
      height: 4.0,
      color: Colors.grey,
    );
}

Widget myDivider2() {
  return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 4.0,
      color: Colors.grey.shade200,
    );
}

void showToast({
  required String text,
  required ToastStates state,}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 10,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );
}

// enum  كذا اختيار من حاجة
enum ToastStates { success, error, waring }
Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;

    case ToastStates.error:
      color = Colors.red;
      break;

    case ToastStates.waring:
      color = Colors.amber;
      break;
  }
  return color;
}

void navigateTo(context, widget) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ), (route) {
      return false;
    });
}

void logOut(context) {
  CacheHelper.removeData(
    key: 'uId',
  ).then((value) {
    if (value) {
      navigateAndFinish(context,  const LoginScreen());
    }
  });
}

void pop(context) {
  Navigator.pop(context);
}


// Widget imagePreview(){
//   return FullScreenWidget(
//     child: Center(
//       child: Image.network(
//         "$image",
//         fit: BoxFit.cover,
//         width: double.infinity,
//         alignment: AlignmentDirectional.topCenter,
//       ),
//     ),
//   );
// }