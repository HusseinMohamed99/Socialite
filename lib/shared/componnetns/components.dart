import 'package:f_app/Pages/Login/login_screen.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:f_app/shared/componnetns/constants.dart';
import 'package:f_app/shared/network/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

Widget defaultTextFormField({
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
  Function? suffixPressed,
}) =>
    TextFormField(
      focusNode: FocusNode(),
      style: const TextStyle(),
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
          color: Colors.grey,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                  color: Colors.grey,
                ),
              )
            : null,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        hintText: hint,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            color: Colors.black,
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

Widget defaultMaterialButton({
  required Function function,
  required String text,
  double width = 300,
  double height = 45.0,
  double radius = 10.0,
  bool isUpperCase = true,
  Function? onTap,
}) =>
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
        onPressed: () {
          function();
        },
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
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(text),
    );

Widget myDivider() => Container(
      width: double.infinity,
      height: 4.0,
      color: Colors.grey,
    );
Widget myDivider2() => Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 4.0,
      color: Colors.grey.shade200,
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 10,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

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

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ), (route) {
      return false;
    });

void logOut(context) {
  CacheHelper.removeData(
    key: 'uId',
  ).then((value) {
    if (value) {
      navigateAndFinish(context, const LoginScreen());
    }
  });
}

void pop(context) {
  Navigator.pop(context);
}

Widget buildPostItem(context) {
  var userModel = SocialCubit.get(context).model;
  return Card(
    color: SocialCubit.get(context).isDark
        ? Colors.white
        : const Color(0xff063750),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 10,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(25),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    '${userModel!.image}',
                  ),
                ),
              ),
              space(15, 0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Text(
                            '${userModel.name}',
                            style: GoogleFonts.lobster(
                              fontSize: 20,
                              height: 1.3,
                              color: SocialCubit.get(context).isDark
                                  ? CupertinoColors.activeBlue
                                  : Colors.white,
                            ),
                          ),
                        ),
                        space(5, 0),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ],
                    ),
                    Text(
                      'May 15,2022 at 9:00 pm',
                      style: GoogleFonts.lobster(
                          fontSize: 15,
                          color: Colors.grey,
                          textStyle: Theme.of(context).textTheme.caption,
                          height: 1.3),
                    ),
                  ],
                ),
              ),
              space(15, 0),
              IconButton(
                splashRadius: 20,
                onPressed: () {},
                icon: Icon(
                  IconlyLight.moreCircle,
                  size: 25,
                  color: SocialCubit.get(context).isDark
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              color: Colors.grey[300],
              height: 2,
              width: double.infinity,
            ),
          ),
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://img.freepik.com/premium-photo/portrait-happy-handsome-man-making-heart-with-fingers-send-affection-his-girlfriend-isolated-pastel-color-background_525549-8487.jpg?w=996',
                  ),
                  fit: BoxFit.cover,
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  IconlyLight.heart,
                  color: Colors.red,
                ),
                label: Text(
                  '1200 Like',
                  style: GoogleFonts.lobster(
                    color: Colors.red,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  IconlyLight.chat,
                  color: Colors.orangeAccent,
                ),
                label: Text(
                  '500 Comment',
                  style: GoogleFonts.lobster(
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Container(
              color: Colors.grey[300],
              height: 2,
              width: double.infinity,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                  '${userModel.image}',
                ),
              ),
              space(10, 0),
              InkWell(
                onTap: () {},
                child: SizedBox(
                  width: 150,
                  child: Text(
                    'Write a comment ...',
                    style: GoogleFonts.lobster(
                      textStyle: Theme.of(context).textTheme.caption,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  IconlyLight.heart,
                  color: Colors.red,
                ),
                label: Text(
                  'Like',
                  style: GoogleFonts.lobster(
                    color: Colors.red,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  IconlyLight.upload,
                  color: Colors.green,
                ),
                label: Text(
                  'Share',
                  style: GoogleFonts.lobster(
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
