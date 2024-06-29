import 'package:electrokimo/data/repositories/authentication/authentication_repository.dart';
import 'package:electrokimo/features/auth/models/user_pa_model.dart';
import 'package:electrokimo/features/auth/screens/sign_up.dart';
import 'package:electrokimo/utils/network/network_manager.dart';
import 'package:electrokimo/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  static VerificationController get instance => Get.find();

  //variables
  late TextEditingController pa = TextEditingController();

  final Rx<UserPaModel> userData = UserPaModel(
    id: 0,
    pa: '',
    status: '',
  ).obs;

  GlobalKey<FormState> verificationFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    pa = TextEditingController(text: userData.value.pa);
  }

  void setUserData(UserPaModel user) {
    userData.value = user;
    pa.text = user.pa;
  }

  UserPaModel get getUserData => userData.value;

  Future<void> verifiyPa() async {
    LoaderScreen.openLoadingDialog();
    //Check Connection
    final isConnected = await NetworkManager.instance.isConnected();

    if (!isConnected) {
      LoaderScreen.stopLoading();
      return;
    }

    final response =
        await AuthenticationRepository.instance.checkpa(pa: pa.text.trim());

    if (response['succeeded'] == true) {
      final paValue = response['data']['pa'];
      final statusValue = response['data']['status'];
      final idValue = response['data']['id'];

      final userData =
          UserPaModel(id: idValue, pa: paValue, status: statusValue);
      VerificationController.instance.setUserData(userData);

      LoaderScreen.stopLoading();
      Get.off(() => const SignUpScreen());
    }
  }
}
