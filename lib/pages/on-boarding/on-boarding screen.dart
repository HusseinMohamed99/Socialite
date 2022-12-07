import 'package:f_app/Pages/Login/login_screen.dart';
import 'package:f_app/Pages/Register/register_screen.dart';
import 'package:f_app/shared/components/components.dart';
import 'package:f_app/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/back.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(
                flex: 1,
              ),
              Expanded(
                child: Text(
                  'Snap\nand\nShare\nevery\nmoments',
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      overflow: TextOverflow.visible,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              space(0, 230),
              Center(
                child: Column(
                  children: [
                    Container(
                        width: 270,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                        ),
                        child: MaterialButton(
                          onPressed: ()
                          {
                            navigateAndFinish(context,  const LoginScreen());
                          },
                          child: Text(
                            'Sign in',
                            style: GoogleFonts.robotoCondensed(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,

                              ),
                            ),
                          ),
                        ),
                    ),
                  space(0, 20),
                    Container(
                      width: 270,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade700,
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                      child: MaterialButton(
                        onPressed: ()
                        {
                          navigateTo(context, const RegisterScreen());
                        },
                        child: Text(
                          'Sign up',
                          style: GoogleFonts.robotoCondensed(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    space(0, 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}