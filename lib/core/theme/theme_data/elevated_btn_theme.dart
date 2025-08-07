import 'package:flutter/material.dart';
import '../colors.dart';


class MaverickAppElevatedButtonTheme {
  MaverickAppElevatedButtonTheme._();

  static ElevatedButtonThemeData elevatedButtonLightTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kButtonDarkColor,
      foregroundColor: kTextLightColor,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),

    ),
  );

  static ElevatedButtonThemeData elevatedButtonDarkTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kButtonDarkColor,
      foregroundColor: kTextLightColor,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}
