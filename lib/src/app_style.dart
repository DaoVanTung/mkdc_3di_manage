import 'package:flutter/material.dart';

class AppStyle {
  AppStyle._internal();
  static final _instance = AppStyle._internal();
  factory AppStyle() {
    return _instance;
  }

  // Padding
  static const double padding4 = 4.0;
  static const double padding8 = 8.0;
  static const double padding12 = 12.0;
  static const double padding16 = 16.0;
  static const double padding32 = 32.0;

  // Font size
  static const double fontSize16 = 16.0;
  static const double fontSize18 = 18.0;
  static const double fontSize20 = 20.0;

  // Icon size
  static const double iconSize18 = 18.0;
  static const double iconSize20 = 20.0;
  static const double iconSize24 = 24.0;

  // Color
  static const primaryColor = Color(0xff13213E);
  static const secondaryColor = Color(0xff1A2A4C);
  static const menuColor = Color(0xff1F325C);
  static const backgroundColor = Color(0xffF0F2F5);
  static const fillColor = Color(0xffDCE0E6);
  static const stokeColor = Color(0xffAEB8C2);
  static const textMenuColor = Color(0xffADB5C3);
  static const borderColor = Color(0xffD9D9D9);
  static const fillButtonColor = Color(0xff354F8A);
  static const fillBarColor = Color(0xffFAFAFA);
  static const whiteColor = Colors.white;
  static const blackColor = Colors.black;
  static const linkColor = Color(0xff1677FF);
  static const dangerColor = Colors.amber;
}
