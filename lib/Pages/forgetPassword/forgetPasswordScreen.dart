import 'package:f_app/Pages/Login/login_screen.dart';
import 'package:f_app/shared/Cubit/restPasswordCubit/rest_password_cubit.dart';
import 'package:f_app/shared/Cubit/restPasswordCubit/rest_password_state.dart';
import 'package:f_app/shared/componnetns/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.light,
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark),
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  emailController.clear();
                  pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
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
                              'Enter the email address associated with your account',
                              overflow: TextOverflow.visible,
                              style: GoogleFonts.robotoCondensed(
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: Colors.grey.shade50,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(40.0),
                              topLeft: Radius.circular(40.0),
                            )),
                        child: Form(
                          key: loginFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
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
                              const SizedBox(
                                height: 40,
                              ),
                              state is ResetPasswordLoadingState
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : defaultTextButton(
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
