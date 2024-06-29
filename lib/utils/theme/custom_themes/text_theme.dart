import 'package:electrokimo/size_config.dart';
import 'package:flutter/material.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme customTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: getProportionateScreenWidth(32),
        fontWeight: FontWeight.bold,
        color: Colors.black),
    headlineMedium: const TextStyle().copyWith(
      fontSize: getProportionateScreenWidth(24),
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: getProportionateScreenWidth(18),
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      fontSize: getProportionateScreenWidth(16),
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      fontSize: getProportionateScreenWidth(16),
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: getProportionateScreenWidth(16),
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: getProportionateScreenWidth(14),
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: getProportionateScreenWidth(14),
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: getProportionateScreenWidth(16),
      fontWeight: FontWeight.w400,
      color: Colors.black.withOpacity(0.5),
    ),
    labelLarge: const TextStyle().copyWith(
      fontSize: getProportionateScreenWidth(16),
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    labelMedium: const TextStyle().copyWith(
      fontSize: getProportionateScreenWidth(12),
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
  );
}
