import 'package:electrokimo/data/repositories/authentication/authentication_repository.dart';
import 'package:electrokimo/features/auth/controllers/verification/verification_controller.dart';
import 'package:electrokimo/features/auth/models/user_pa_model.dart';
import 'package:electrokimo/navigation_menu.dart';
import 'package:electrokimo/utils/network/network_manager.dart';
import 'package:electrokimo/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

class LoginController extends GetxController {
  //Variables
  final policeAbonnement = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs;
  final localStorage = GetStorage();

  final Rx<UserPaModel> userData = UserPaModel(
    id: 0,
    pa: '',
    status: '',
  ).obs;

  get getUserData => userData.value;

  //Login
  Future<void> login() async {
    try {
      LoaderScreen.openLoadingDialog();
      //Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        LoaderScreen.stopLoading();
        return;
      }

      final loginData = await AuthenticationRepository.instance.loginClient(
        userName: policeAbonnement.text.trim(),
        password: password.text.trim(),
      );

      if (loginData['succeeded'] == true) {
        final token = loginData['data']['token'];
        final userPaInfo = await AuthenticationRepository.instance
            .checkpa(pa: policeAbonnement.text.trim());
        final paValue = userPaInfo['data']['pa'];
        final statusValue = userPaInfo['data']['status'];
        final idValue = userPaInfo['data']['id'];

        final userData =
            UserPaModel(id: idValue, pa: paValue, status: statusValue);
        VerificationController.instance.setUserData(userData);

        localStorage.write("token", token);
        Get.to(() => const NavigationMenu());
      }
      //Redirect
    } catch (e) {
      Get.snackbar(
        "Erreur",
        e.toString(),
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(
          Iconsax.warning_2,
          color: Colors.white,
        ),
      );
    }
  }
}
