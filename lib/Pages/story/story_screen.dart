import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'Story Screen',
      style: GoogleFonts.lobster(
        color: Colors.blue,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
    ));
  }
}
