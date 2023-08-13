import 'package:flutter/material.dart';

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
// (0,0) 1. Point
    path.lineTo(0, h); //2. Point
    path.quadraticBezierTo(w * 0.5, h - 100, w, h); //4. Point
    path.lineTo(w, 0); //5. Point
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
