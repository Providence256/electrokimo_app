import 'package:electrokimo/size_config.dart';
import 'package:flutter/material.dart';

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._();

  static final customOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
      backgroundColor: Colors.grey.shade200,
      side: BorderSide(color: Colors.grey.withOpacity(0.5)),
      textStyle: TextStyle(
        fontSize: getProportionateScreenWidth(16),
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(16),
        horizontal: getProportionateScreenWidth(20),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  );
}
