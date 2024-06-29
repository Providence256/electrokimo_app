import 'package:electrokimo/bindings/general_bindings.dart';
import 'package:electrokimo/features/auth/screens/login.dart';
import 'package:electrokimo/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: TAppTheme.customTheme,
      initialBinding: GeneralBindings(),
      home: const Scaffold(
        backgroundColor: Colors.blue,
        body: LoginScreen(),
      ),
    );
  }
}
