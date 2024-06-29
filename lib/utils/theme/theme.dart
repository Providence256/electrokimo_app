import 'package:electrokimo/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:electrokimo/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:electrokimo/utils/theme/custom_themes/text_field_theme.dart';
import 'package:electrokimo/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData customTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextTheme.customTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.customElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.customOutlinedButtonTheme,
    inputDecorationTheme: TTextFieldTheme.customDecorationTheme,
  );
}
