import 'package:flutter/material.dart';

import '../colors.dart';

class MaverickAppTextTheme {
  MaverickAppTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    titleLarge: const TextStyle().copyWith(
      color: kTextDarkColor,
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: const TextStyle().copyWith(
      color: kTextDarkColor,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: const TextStyle().copyWith(
      color: kTextSecondaryColor,
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
    ),

    // body text
    bodyLarge: const TextStyle().copyWith(
      color: kTextDarkColor,
      fontSize: 16.0,
    ),
    bodyMedium: const TextStyle().copyWith(
      color: kTextDarkColor,
      fontSize: 14.0,
    ),
    bodySmall: const TextStyle().copyWith(
      color: kTextSecondaryColor,
      fontSize: 14.0,
    ),

    // label text
    labelLarge: const TextStyle().copyWith(
      color: kTextDarkColor,
      fontSize: 14.0,
    ),
    labelMedium: const TextStyle().copyWith(
      color: kTextDarkColor,
      fontSize: 13.0,
    ),
    labelSmall: const TextStyle().copyWith(
      color: kTextSecondaryColor,
      fontSize: 12.5,
    ),
  );

  // Dark theme text
  static TextTheme darkTextTheme = TextTheme(
    titleLarge: const TextStyle().copyWith(
      color: kTextLightColor,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: const TextStyle().copyWith(
      color: kTextLightColor,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: const TextStyle().copyWith(
      color: kTextSecondaryColor,
      fontSize: 16.0,
    ),

    // body text
    bodyLarge: const TextStyle().copyWith(
      color: kTextLightColor,
      fontSize: 16.0,
    ),
    bodyMedium: const TextStyle().copyWith(
      color: kTextLightColor,
      fontSize: 14.0,
    ),
    bodySmall: const TextStyle().copyWith(
      color: kTextSecondaryColor,
      fontSize: 14.0,
    ),

    // label text
    labelLarge: const TextStyle().copyWith(
      color: kTextDarkColor,
      fontSize: 14.0,
    ),
    labelMedium: const TextStyle().copyWith(
      color: kTextDarkColor,
      fontSize: 13.0,
    ),
    labelSmall: const TextStyle().copyWith(
      color: kTextSecondaryColor,
      fontSize: 12.5,
    ),
  );
}
