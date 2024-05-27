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
  static const double fontSize12 = 12.0;
  static const double fontSize14 = 14.0;
  static const double fontSize16 = 16.0;
  static const double fontSize18 = 18.0;
  static const double fontSize20 = 20.0;

  // Icon size
  static const double iconSize18 = 18.0;
  static const double iconSize20 = 20.0;
  static const double iconSize24 = 24.0;

  // Color
  static const primaryColor = Color(0xff13213E);
  static const whiteColor = Colors.white;
  static const blackColor = Colors.black;
  static const dangerColor = Colors.amber;
  static const lightBlueColor = Colors.lightBlue;
}
