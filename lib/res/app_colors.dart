import 'dart:ui';

import 'package:flutter/material.dart';

class AppColor{
  // static const Color black= Colors.black;
  // static const Color black= Colors.black;
  static const Color black= Colors.black;
  static const Color lightGrayOne= Color(0xff333332);
  static const Color gray= Color(0xff252a34);
  static const Color darkGray= Color(0xff131313);
  static const Color darkGrayTwo= Color(0xff131313);
  static const Color lightGray= Color(0xffa8a5a1);
  static const Color white= Colors.white;
  static const Color yellow= Color(0xFFE3BE46);
  static const Color red= Color(0xFFd2312a);
  static const Color blue= Color(0xff0068cf);
  static const Color orange= Colors.orange;
  static const Color darkBlue= Color(0xff030c23);
  static const lightMarron = Color(0xFF2c0f52);
  static const Color  lightBlue = Color(0xff9ac5b9);
  static const Color  lightCream = Color(0xffe5cf8b);
  static const Color  lightMix = Color(0xffc6cda5);
  static const Color  darkGreen = Color(0xff569123);
  static const Color  peetch = Color(0xfff1e0d8);
  static const green = Colors.green;

  static const LinearGradient appBarGradient = LinearGradient(
    colors: [
      gray,
      black,
    ],
    stops: [0.1, 0.9,],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient gradient = LinearGradient(
    colors: [
      AppColor.black,
      AppColor.gray,
      AppColor.black,
    ],
    // stops: [0.1, 0.9,],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient appBg = LinearGradient(
      colors: [Color(0xfff1e0d8), AppColor.peetch,Color(0xffe5cf8b)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter
  );
  static const LinearGradient transparentGradient = LinearGradient(
    colors: [Colors.transparent,Colors.transparent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient greenGradient = LinearGradient(
      colors: [gray,black],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight
  );
  static const LinearGradient boxGradient = LinearGradient(
    colors: [
      Color(0xFF2b374a),
      Color(0xFF2b374a),

    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient whiteGradient = LinearGradient(
    colors: [
      Colors.white,
      Colors.white70,
    ],
    stops: [0.1, 0.9,],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}