import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoaderScreen {
  static void openLoadingDialog() {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        child: Center(
          child: Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(7),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: CircularProgressIndicator(
              color: Colors.blue.shade800,
            ),
          ),
        ),
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
