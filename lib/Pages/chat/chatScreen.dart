import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Chat Screen',  style: GoogleFonts.lobster(
      color: Colors.blue,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),));

  }
}
