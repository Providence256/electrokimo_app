import 'package:electrokimo/size_config.dart';
import 'package:flutter/material.dart';

class TAppBarTheme {
  TAppBarTheme._();

  static final customAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.blue,
    iconTheme: const IconThemeData(color: Colors.black, size: 24),
    titleTextStyle: TextStyle(
      fontSize: getProportionateScreenWidth(18),
      fontWeight: FontWeight.w600,
    ),
  );
}
