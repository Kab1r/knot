import 'package:flutter/material.dart';

class ThemeColors {
  static const primaryColor = const Color(0xFFe46d00); //#e46d00
  static const accentColor = const Color(0xFF0076e4); //#0076e4
  static const backgroundColor = const Color(0xFF61bbff); //#30a6ff  // #61bbff
  static const tertiaryColor = const Color(0xFF0b45b3); //#0b45b3
  static const dividerColor = const Color(0xFF262728); //#262728
}

var backgroundBoxDecor = BoxDecoration(color: ThemeColors.backgroundColor);

final ThemeData appTheme = ThemeData.light().copyWith(
  accentColor: ThemeColors.accentColor,
  primaryColor: ThemeColors.primaryColor,
  backgroundColor: ThemeColors.backgroundColor,
);
