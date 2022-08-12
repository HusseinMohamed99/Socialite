import 'package:f_app/Pages/Login/login_screen.dart';
import 'package:f_app/Pages/Register/register_screen.dart';
import 'package:f_app/shared/componnetns/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Stack(
      children:
      [
        Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/back.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.light,
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.light),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  SizedBox(
                    width: 220,
                    height: 1,
                    child: Text(
                      'Snap and Share every moments',
                      style: GoogleFonts.libreBaskerville(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          overflow: TextOverflow.visible,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 230,
                  ),
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
                                navigateTo(context,  const LoginScreen());
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
                        const SizedBox(
                          height: 20,
                        ),
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
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}