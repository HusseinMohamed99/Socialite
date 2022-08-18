import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class UserScreen extends StatelessWidget {

  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Center(child: Text('Users Screen', style: GoogleFonts.lobster(
      color: Colors.blue,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),),
    );
  }

}
