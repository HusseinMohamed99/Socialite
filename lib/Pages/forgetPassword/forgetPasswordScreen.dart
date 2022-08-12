import 'package:f_app/Pages/Login/login_screen.dart';
import 'package:f_app/shared/Cubit/restPasswordCubit/rest_password_cubit.dart';
import 'package:f_app/shared/Cubit/restPasswordCubit/rest_password_state.dart';
import 'package:f_app/shared/componnetns/components.dart';
import 'package:f_app/shared/componnetns/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/Cubit/socialCubit/SocialCubit.dart';

class RestPasswordScreen extends StatelessWidget {
  var loginFormKey = GlobalKey<FormState>();
  var emailController = TextEditingController();

  RestPasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordStates>(
        listener: (context, state) {
          if (state is ResetPasswordSuccessState) {
            navigateAndFinish(context, const LoginScreen());
          }
        },
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor:
                cubit.isDark ? Colors.white : const Color(0xff063750),
            // backgroundColor:
            // cubit.isDark ? Colors.white : Colors.white,
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor:
                    cubit.isDark ? Colors.white : const Color(0xff063750),
                statusBarIconBrightness:
                    cubit.isDark ? Brightness.dark : Brightness.light,
                statusBarBrightness:
                    cubit.isDark ? Brightness.dark : Brightness.light,
              ),
              backgroundColor:
                  cubit.isDark ? Colors.white : const Color(0xff063750),
              elevation: 1,
              leading: IconButton(
                onPressed: () {
                  emailController.clear();
                  pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: cubit.isDark ? Colors.black : Colors.white,
                ),
              ),
              titleSpacing: 1,
              title: Text(
                'Forget Password',
                style: GoogleFonts.lobster(
                  textStyle: TextStyle(
                    color: cubit.isDark ? Colors.black : Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            body: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Resetpassword.png'),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enter the E-mail address associated with your account',
                              style: GoogleFonts.libreBaskerville(
                                fontSize: 27,
                                fontWeight: FontWeight.w900,
                                color:
                                    cubit.isDark ? Colors.black : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: double.infinity,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          20,
                          25,
                          20,
                          0,
                        ),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurStyle: BlurStyle.outer,
                                  color: cubit.isDark
                                      ? const Color(0xff063750)
                                      : Colors.white,
                                  blurRadius: 9,
                                  spreadRadius: 10,
                                  offset: const Offset(0, 1))
                            ],
                            border: Border.all(
                              color: cubit.isDark
                                  ? const Color(0xff063750)
                                  : Colors.white,
                            ),
                            color: cubit.isDark
                                ? Colors.white
                                : const Color(0xff063750),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(50.0),
                              topLeft: Radius.circular(50.0),
                            )),
                        child: Form(
                          key: loginFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             space(0, 10),
                              defaultTextFormField(
                                context: context,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                prefix: Icons.email,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Your E-mail';
                                  }
                                  return null;
                                },
                                hint: 'E-mail Address',
                              ),
                             const Spacer(),
                              state is ResetPasswordLoadingState
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : Container(
                                color: cubit.isDark
                                    ? Colors.blue
                                    : Colors.white,
                                    child: defaultTextButton(
                                           context: context,
                                        text: 'RESET PASSWORD',
                                        function: () {
                                          if (loginFormKey.currentState!
                                              .validate()) {
                                            ResetPasswordCubit.get(context)
                                                .resetPassword(
                                              email: emailController.text,
                                            );
                                          }
                                        },
                                      ),
                                  ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
