import 'package:flutter/material.dart';

import '../colors.dart';

class MaverickAppInputDecorationTheme {
  MaverickAppInputDecorationTheme._();

  static InputDecorationTheme inputDecorationLightTheme = InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(12),
    ),
    hintStyle: TextStyle(color: kTextFormFieldLabelColor, fontSize: 14.0),
    labelStyle: TextStyle(color: Colors.teal, fontSize: 14.0),
  );

  static InputDecorationTheme inputDecorationDarkTheme = InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(12),
    ),
    hintStyle: TextStyle(color: kTextFormFieldLabelColor),
    labelStyle: TextStyle(color: Colors.teal),
  );
}
