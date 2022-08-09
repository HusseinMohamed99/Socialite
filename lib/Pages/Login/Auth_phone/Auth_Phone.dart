import 'package:f_app/Pages/Login/Auth_phone/OTPS.dart';
import 'package:f_app/shared/componnetns/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthPhone extends StatefulWidget {
  const AuthPhone({Key? key}) : super(key: key);

  @override
  AuthPhoneState createState() => AuthPhoneState();
}

class AuthPhoneState extends State<AuthPhone> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Phone Auth'),
        leading: IconButton(
          onPressed: () {
            pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
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
              child: const Center(
                child: Text(
                  'Phone Authentication',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all( 20),
              child: TextFormField(

                decoration: const InputDecoration(
                  focusedBorder:  OutlineInputBorder(
                    borderRadius:  BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide:  BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  enabledBorder:  OutlineInputBorder(
                    borderRadius:  BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide:  BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  errorBorder:  OutlineInputBorder(
                    borderRadius:  BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide:  BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'Phone Number',
                  prefix: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('+2',style: TextStyle(color: Colors.red),),
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
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OTPScreen(controller.text)));
              },
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
