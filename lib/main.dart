import 'package:electrokimo/app.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  initializeDateFormatting("fr_FR", null).then((_) => runApp(const App()));
}


//http://www.bsielectrokimo.com/api/