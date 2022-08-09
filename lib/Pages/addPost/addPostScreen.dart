import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Add Posts Screen',  style: GoogleFonts.lobster(
      color: Colors.blue,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),));

  }
}
