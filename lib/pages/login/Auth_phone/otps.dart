import 'package:f_app/layout/Home/home_layout.dart';
import 'package:f_app/shared/components/components.dart';
import 'package:f_app/shared/cubit/socialCubit/SocialCubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  final String phone;

  const OTPScreen(this.phone, {Key? key}) : super(key: key);

  @override
  OTPScreenState createState() => OTPScreenState();
}

class OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();

  final defaultPinTheme = PinTheme(
    width: 56.w,
    height: 56.h,
    textStyle: TextStyle(
        fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(10).r,
    ),
  );
  @override
  Widget build(BuildContext context) {
    var cubit = SocialCubit.get(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Verification',
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
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40).r,
            child: Center(
              child: Text(
                'Verify +2${widget.phone}',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    color: cubit.isLight ? Colors.black : Colors.white,
                    fontSize: 20.sp,
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
                    .signInWithCredential(
                  PhoneAuthProvider.credential(
                      verificationId: _verificationCode!, smsCode: pin),
                )
                    .then((value) async {
                  if (value.user != null) {
                    navigateAndFinish(
                      context,
                      const HomeLayout(),
                    );
                  }
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor:
                        cubit.isLight ? Colors.black : Colors.white,
                    content: Text(
                      error.toString(),
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: cubit.isLight ? Colors.black : Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ));
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
              SocialCubit.get(context).getUserData();
            navigateAndFinish(
              context,
              const HomeLayout(),
            );
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
      timeout: const Duration(seconds: 120),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }
}
