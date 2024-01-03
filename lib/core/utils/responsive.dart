import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive(
      {super.key,
      required this.mobile,
      required this.tablet,
      required this.desktop});
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: computeSize(size),
    );
  }

  Widget computeSize(Size size) {
    if (size.width < 800) {
      return mobile;
    } else if (size.width > 1000 && size.width < 2000) {
      return tablet;
    } else {
      return desktop;
    }
  }
}
