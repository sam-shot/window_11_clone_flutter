import 'package:flutter/material.dart';

class AppTextStyle {
  static  normal(double size){
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w500,
      color: Colors.black
    );
  }
  static  bold(double size){
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w600,
      color: Colors.black
    );
  }
  static  thick(double size){
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w700,
      color: Colors.black
    );
  }
}