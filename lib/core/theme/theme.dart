import 'package:flutter/material.dart';
import 'package:maverick_app/core/theme/color_scheme.dart';
import 'package:maverick_app/core/theme/colors.dart';
import 'package:maverick_app/core/theme/theme_data/elevated_btn_theme.dart';

import 'theme_data/input_decoration_theme_data.dart';
import 'theme_data/text_theme_data.dart';

class MaverickAppTheme {
  MaverickAppTheme._();

  static ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    colorScheme: MaverickAppColorScheme.colorSchemeLight,
    dividerColor: Colors.white,
    elevatedButtonTheme: MaverickAppElevatedButtonTheme.elevatedButtonLightTheme,
    inputDecorationTheme: MaverickAppInputDecorationTheme.inputDecorationLightTheme,
    // progressIndicatorTheme: PretiumAppProgressIndicatorTheme.progressIndicatorLightTheme,
    scaffoldBackgroundColor: kScaffoldBgLightColor,
    textTheme: MaverickAppTextTheme.lightTextTheme,
  );

  static ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    colorScheme: MaverickAppColorScheme.colorSchemeDark,
    dividerColor: Colors.black,
    elevatedButtonTheme: MaverickAppElevatedButtonTheme.elevatedButtonDarkTheme,
    inputDecorationTheme: MaverickAppInputDecorationTheme.inputDecorationDarkTheme,
    // progressIndicatorTheme: PretiumAppProgressIndicatorTheme.progressIndicatorDarkTheme,
    scaffoldBackgroundColor: kScaffoldBgDarkcolor,
    textTheme: MaverickAppTextTheme.darkTextTheme,
  );
}
