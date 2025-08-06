import 'package:flutter/material.dart';

import '../colors.dart';


class MaverickAppElevatedButtonTheme {
  MaverickAppElevatedButtonTheme._();

  static ElevatedButtonThemeData elevatedButtonLightTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll<Color>(kButtonDarkColor),
      foregroundColor: WidgetStatePropertyAll<Color>(kTextLightColor),
      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 16.0)),
      shape: WidgetStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    ),
  );

  static ElevatedButtonThemeData elevatedButtonDarkTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll<Color>(kButtonDarkColor),
      foregroundColor: WidgetStatePropertyAll<Color>(kTextLightColor),
      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 16.0)),
      shape: WidgetStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    )
  );
}
