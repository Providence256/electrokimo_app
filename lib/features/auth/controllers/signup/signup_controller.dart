import 'package:electrokimo/common/widgets/success-screen/success_screen.dart';
import 'package:electrokimo/data/repositories/authentication/authentication_repository.dart';
import 'package:electrokimo/features/auth/controllers/verification/verification_controller.dart';
import 'package:electrokimo/utils/network/network_manager.dart';
import 'package:electrokimo/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //Variables
  final pa = TextEditingController();
  final telephone = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final hidePassword = true.obs;
  final confirmHidePassword = true.obs;
  final RxString countryCode = "+243".obs;

  //SIGN UP
  Future<void> signup() async {
    try {
      LoaderScreen.openLoadingDialog();
      //Check Internet connection
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        LoaderScreen.stopLoading();
        return;
      }

      //Check Password
      if (password.text.trim() != confirmPassword.text.trim()) {
        LoaderScreen.stopLoading();
        return;
      }

      final fullNumber = countryCode.value + telephone.text.trim();

      // final formData = {
      //   'pa': pa.text.trim(),
      //   'email': email.text.trim(),
      //   'telephone': fullNumber,
      //   'password': password.text.trim(),
      // };

      // print("data");
      final userData = Get.find<VerificationController>();

      //Register Client
      await AuthenticationRepository.instance.registerClient(
        pa: userData.pa.text,
        email: email.text.trim(),
        phoneNumber: fullNumber,
        password: password.text.trim(),
      );

      LoaderScreen.stopLoading();
      Get.to(() => const SuccessScreen());
    } catch (e) {
      LoaderScreen.stopLoading();

      Get.snackbar(
        "Erreur",
        e.toString(),
        isDismissible: true,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        icon: const Icon(
          Iconsax.warning_2,
          color: Colors.white,
        ),
        duration: const Duration(seconds: 3),
      );
    }
  }
}
