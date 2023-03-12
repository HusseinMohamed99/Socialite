import 'package:f_app/Pages/login/Auth_phone/Otps.dart';
import 'package:f_app/shared/components/components.dart';
import 'package:f_app/shared/cubit/socialCubit/SocialCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthPhone extends StatefulWidget {
  const AuthPhone({Key? key}) : super(key: key);

  @override
  AuthPhoneState createState() => AuthPhoneState();
}

class AuthPhoneState extends State<AuthPhone> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var cubit = SocialCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Phone Auth',
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: cubit.isLight ? Colors.black : Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            pop(context);
          },
          icon: Icon(
            IconlyLight.arrowLeft2,
            color: cubit.isLight ? Colors.black : Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/EnterOTP.png'),
                ),
              ),
            ),
            Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 60).r,
                child: Center(
                  child: Text(
                    'Phone Authentication',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        color: cubit.isLight ? Colors.black : Colors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20).r,
                child: TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ).r,
                      borderSide: BorderSide(
                        color: cubit.isLight ? Colors.black : Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ).r,
                      borderSide: BorderSide(
                        color: cubit.isLight ? Colors.black : Colors.white,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ).r,
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                    hintText: 'Phone Number',
                    hintStyle: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        color: cubit.isLight ? Colors.black : Colors.white,
                      ),
                    ),
                    prefix: Padding(
                      padding: EdgeInsetsDirectional.only(end: 8.r),
                      child: Icon(
                        IconlyLight.call,
                        size: 24.sp,
                      ),
                    ),
                  ),
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                  controller: controller,
                ),
              )
            ]),
            Container(
              margin: const EdgeInsets.all(10).r,
              width: 200.w,
              child: MaterialButton(
                color: cubit.isLight ? Colors.black : Colors.white,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OTPScreen(controller.text),
                    ),
                  );
                },
                child: Text(
                  'Next',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: cubit.isLight ? Colors.white : Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
