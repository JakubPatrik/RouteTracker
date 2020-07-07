import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.moveTo(size.width, 0);
    p.lineTo(size.width, 0);
    p.lineTo(size.width, 175);
    //p.lineTo(size.width*0.4, size.height * 0.3);
    p.arcToPoint(
      Offset(75, 0),
      radius: const Radius.elliptical(25.0, 15.0),
      rotation: 0.0,
    );
    //p.lineTo(0.0, 150.0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}