import 'package:f_app/layout/Home/home_layout.dart';
import 'package:f_app/shared/componnetns/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../../shared/Cubit/socialCubit/SocialCubit.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
   const OTPScreen(this.phone, {Key? key}) : super(key: key);
  @override
  OTPScreenState createState() => OTPScreenState();
}

class OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(10),
    ),
  );
  @override
  Widget build(BuildContext context) {
    var cubit = SocialCubit.get(context);
    return Scaffold(
      backgroundColor:
      cubit.isDark ? Colors.white : const Color(0xff063750),
      key: _scaffoldkey,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: cubit.isDark ?  Colors.white : const Color(0xff063750),
          statusBarIconBrightness:cubit.isDark ? Brightness.dark : Brightness.light,
          statusBarBrightness: cubit.isDark ? Brightness.dark : Brightness.light,
        ),
        backgroundColor:
        cubit.isDark ? Colors.white : const Color(0xff063750),
        elevation: 0,
        title: Text('Verification',style: GoogleFonts.lobster(
          textStyle: TextStyle(
            color:
            cubit.isDark ? Colors.black : Colors.white,
            fontSize: 20,
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
            color:  cubit.isDark ? Colors.black : Colors.white,

          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'Verify +2${widget.phone}',
                style: GoogleFonts.lobster(
                  textStyle: TextStyle(
                    color:
                    cubit.isDark ? Colors.black : Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Pinput(

              length: 6,
              defaultPinTheme: defaultPinTheme,
              controller: _pinPutController,
              pinAnimationType: PinAnimationType.fade,
              closeKeyboardWhenCompleted: false,
              onSubmitted: (pin) async {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _verificationCode!, smsCode: pin))
                      .then((value) async {
                    if (value.user != null) {
                     navigateAndFinish(context,  const HomeLayout());
                    }
                  }).catchError((error)
                  {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(backgroundColor: cubit.isDark ? Colors.black : Colors.white,content: Text(error.toString(),style: GoogleFonts.lobster(
                      textStyle: TextStyle(
                        color:
                        cubit.isDark ? Colors.black : Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),),));
                  });
              },
            ),
          )
        ],
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+2${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              navigateAndFinish(context,  const HomeLayout());
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint(e.message);
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: const Duration(seconds: 120));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }
}

