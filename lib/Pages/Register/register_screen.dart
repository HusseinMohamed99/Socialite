import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:f_app/Pages/Login/Auth_phone/Auth_Phone.dart';
import 'package:f_app/shared/Cubit/loginCubit/cubit.dart';
import 'package:f_app/shared/Cubit/registerCubit/cubit.dart';
import 'package:f_app/layout/Home/home_layout.dart';
import 'package:f_app/shared/Cubit/registerCubit/state.dart';
import 'package:f_app/shared/componnetns/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class RegisterScreen extends StatelessWidget {


  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state)
        {
          if(state is UserCreateSuccessState)
          {
            navigateAndFinish(context,  const HomeLayout());
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
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          child: Text(
                            'Sign up Now',
                            style: GoogleFonts.lobster(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Please enter your information',
                          style: GoogleFonts.lobster(
                            textStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Full Name',
                          style: GoogleFonts.lobster(
                            textStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        defaultTextFormField(
                          context: context,
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone';
                            }
                            return null;
                          },
                          hint: 'Name',
                          prefix: Icons.person_outline_rounded,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Phone',
                          style: GoogleFonts.lobster(
                            textStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        defaultTextFormField(
                          context: context,
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone';
                            }
                            return null;
                          },
                          hint: 'Phone',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'E-mail Address',
                          style: GoogleFonts.lobster(
                            textStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        defaultTextFormField(
                          context: context,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your E-mail';
                            }
                            return null;
                          },
                          hint: 'E-mail',
                          prefix: Icons.alternate_email,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Password',
                          style: GoogleFonts.lobster(
                            textStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        defaultTextFormField(
                          context: context,
                          controller: passController,
                          keyboardType: TextInputType.visiblePassword,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          hint: 'Password',
                          prefix: Icons.lock_outline_rounded,
                          suffix: RegisterCubit
                              .get(context)
                              .suffix,
                          isPassword: RegisterCubit
                              .get(context)
                              .isPassword,
                          suffixPressed: () {
                            RegisterCubit.get(context).changePassword();
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context) =>
                                defaultMaterialButton(
                                  function: ()
                                  {
                                    if (formKey.currentState!.validate())
                                    {
                                      RegisterCubit.get(context).userRegister(
                                          email: emailController.text,
                                          password: passController.text,
                                          phone: phoneController.text,
                                          name: nameController.text,
                                      );
                                    }

                                  },
                                  text: 'Register',
                                ), fallback: (BuildContext context) =>
                              const Center(child:  CircularProgressIndicator()),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Already have an account?',
                              style: GoogleFonts.lobster(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                pop(context);
                              },
                              child: Text(
                                'Login',
                                style: GoogleFonts.lobster(
                                  textStyle: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                UserCredential userCredential =
                                await LoginCubit.get(context)
                                    .signInWithGoogle();
                                debugPrint(userCredential.toString());
                              },
                              child: const CircleAvatar(
                                backgroundImage: AssetImage('assets/images/Google_Logo.png',) ,
                                radius: 30,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            InkWell(
                              onTap: () {
                                navigateTo(context, const AuthPhone());
                              },
                              child: const CircleAvatar(
                                backgroundImage: AssetImage('assets/images/phone.png',) ,
                                radius: 50,
                                backgroundColor: Colors.transparent,
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
