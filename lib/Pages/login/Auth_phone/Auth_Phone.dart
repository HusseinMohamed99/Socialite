import 'package:f_app/Pages/login/Auth_phone/Otps.dart';
import 'package:f_app/shared/componnetns/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/Cubit/socialCubit/SocialCubit.dart';

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
      backgroundColor:
      cubit.isDark ? Colors.white : const Color(0xff063750),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: cubit.isDark ?  Colors.white : const Color(0xff063750),
          statusBarIconBrightness:cubit.isDark ? Brightness.dark : Brightness.light,
          statusBarBrightness: cubit.isDark ? Brightness.dark : Brightness.light,
        ),
        backgroundColor:
        cubit.isDark ? Colors.white : const Color(0xff063750),
        elevation: 0,
        title:  Text('Phone Auth',style: GoogleFonts.lobster(
          textStyle: TextStyle(
            color:
            cubit.isDark ? Colors.black : Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),),
        leading: IconButton(
          onPressed: () {
            pop(context);
          },
          icon:  Icon(
            IconlyLight.arrowLeft2,
            color:  cubit.isDark ? Colors.black : Colors.white,

          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/EnterOTP.png'),
                ),
              ),
            ),
            Column(
                children: [
              Container(
                margin: const EdgeInsets.only(top: 60),
                child:  Center(
                  child: Text(
                    'Phone Authentication',
                    style: GoogleFonts.lobster(
                      textStyle: TextStyle(
                        color:
                        cubit.isDark ? Colors.black : Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: TextFormField(
                  decoration:  InputDecoration(
                    focusedBorder:  OutlineInputBorder(
                      borderRadius:  const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide:  BorderSide(
                     color: cubit.isDark ? Colors.black : Colors.white,
                      ),
                    ),
                    enabledBorder:  OutlineInputBorder(
                      borderRadius:  const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide:  BorderSide(
                        color:  cubit.isDark ? Colors.black : Colors.white,
                      ),
                    ),
                    errorBorder:  const OutlineInputBorder(
                      borderRadius:  BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide:  BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                    hintText: 'Phone Number',
                    hintStyle:  GoogleFonts.lobster(textStyle: TextStyle(
                  color:
                    cubit.isDark ? Colors.black : Colors.white,

                  ),),
                    prefix: const Padding(
                      padding: EdgeInsetsDirectional.only(end: 8),
                      child: Icon(IconlyLight.call),
                    ),
                  ),
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                  controller: controller,
                ),
              )
            ]),
            Container(
              margin: const EdgeInsets.all(10),
              width: 200,
              child: MaterialButton(
                color:   cubit.isDark ? Colors.black : Colors.white,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OTPScreen(controller.text)));
                },
                child:  Text(
                  'Next',
                  style: GoogleFonts.lobster(textStyle: TextStyle(
                    color:
                    cubit.isDark ? Colors.white : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
