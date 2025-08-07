import 'package:flutter/material.dart';

import '../colors.dart';

class MaverickAppTextTheme {
  MaverickAppTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    titleLarge: const TextStyle(
      color: kTextDarkColor,
      fontSize: 32.0,
      fontFamily: 'WorkSans',
      fontWeight: FontWeight.bold,
    ),
    titleMedium: const TextStyle(
      color: kTextDarkColor,
      fontSize: 24.0,
      fontFamily: 'WorkSans',
      fontWeight: FontWeight.bold,
    ),
    titleSmall: const TextStyle(
      color: kTextSecondaryColor,
      fontSize: 16.0,
      fontFamily: 'WorkSans',
      fontWeight: FontWeight.normal,
    ),

    // body text
    bodyLarge: const TextStyle(
      color: kTextDarkColor,
      fontSize: 16.0,
      fontFamily: 'WorkSans',
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: const TextStyle(
      color: kTextDarkColor,
      fontSize: 14.0,
      fontFamily: 'WorkSans',
    ),
    bodySmall: const TextStyle(
      color: kTextSecondaryColor,
      fontSize: 14.0,
      fontFamily: 'WorkSans',
    ),

    // label text
    labelLarge: const TextStyle(
      color: kTextDarkColor,
      fontSize: 14.0,
      fontFamily: 'WorkSans',
    ),
    labelMedium: const TextStyle(
      color: kTextDarkColor,
      fontSize: 13.0,
      fontFamily: 'WorkSans',
    ),
    labelSmall: const TextStyle(
      color: kTextSecondaryColor,
      fontSize: 12.5,
      fontFamily: 'WorkSans',
    ),
  );

  // Dark theme text
  static TextTheme darkTextTheme = TextTheme(
    titleLarge: const TextStyle(
      color: kTextLightColor,
      fontSize: 32.0,
      fontFamily: 'WorkSans',
      fontWeight: FontWeight.bold,
    ),
    titleMedium: const TextStyle(
      color: kTextLightColor,
      fontSize: 24.0,
      fontFamily: 'WorkSans',
      fontWeight: FontWeight.bold,
    ),
    titleSmall: const TextStyle(
      color: kTextSecondaryColor,
      fontSize: 14.0,
      fontFamily: 'WorkSans',
    ),

    // body text
    bodyLarge: const TextStyle(
      color: kTextLightColor,
      // fontSize: 20.0,
      fontFamily: 'WorkSans',
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: const TextStyle(
      color: kTextLightColor,
      // fontSize: 14.0,
      fontFamily: 'WorkSans',
      fontWeight: FontWeight.w500,
    ),
    bodySmall: const TextStyle(
      color: kTextSecondaryColor,
      fontSize: 14.0,
      fontFamily: 'WorkSans',
    ),

    // label text
    labelLarge: const TextStyle(
      color: kTextSecondaryColor,
      fontSize: 14.0,
      fontFamily: 'WorkSans',
    ),
    labelMedium: const TextStyle(
      color: kTextSecondaryColor,
      fontSize: 13.0,
      fontFamily: 'WorkSans',
    ),
    labelSmall: const TextStyle(
      color: kTextSecondaryColor,
      fontSize: 12.5,
      fontFamily: 'WorkSans',
    ),
  );
}
