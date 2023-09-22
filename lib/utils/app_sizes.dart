import 'package:flutter/material.dart';

class AppSizes {
  AppSizes._();

  static const microPadding = 4.0;
  static const smallPadding = 8.0;
  static const defaultPadding = 16.0;
  static const largePadding = 24.0;
  static const mediumPadding = 20.0;
  static const extralargePadding = 28.0;
  static const xlPadding = 32.0;
  static const buttonSize = 40.0;
  static const xxlPadding = 64.0;

  static const microMargin = 4.0;
  static const smallMargin = 8.0;
  static const defaultMargin = 16.0;
  static const largeMargin = 24.0;
  static const mediumMargin = 18.0;

  static const defaultHeaderSize = 16.0;

  static const smallRoundedRadius = 8.0;
  static const defaultRoundedRadius = 16.0;
  static const largeRoundedRadius = 24.0;

  static double getWidth(BuildContext context, {double percent = 100}) =>
      percent / 100 * MediaQuery.of(context).size.width;

  static double getHeight(BuildContext context, {double percent = 100}) =>
      percent / 100 * MediaQuery.of(context).size.height;

  static TextStyle setStyle(
          double fontSize, FontWeight fontWeight, Color color) =>
      TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
}
