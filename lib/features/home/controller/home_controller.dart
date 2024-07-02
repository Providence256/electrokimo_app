import 'dart:async';

import 'package:electrokimo/data/repositories/authentication/authentication_repository.dart';
import 'package:electrokimo/data/repositories/authentication/facture_repository.dart';
import 'package:electrokimo/features/auth/controllers/verification/verification_controller.dart';
import 'package:electrokimo/utils/network/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  final AuthenticationRepository authRepo = AuthenticationRepository.instance;

  var userName = ''.obs;
  var email = ''.obs;
  var periode = ''.obs;
  var tauxChange = ''.obs;
  final factureRappel = {}.obs;
  final lastFacture = {}.obs;
  final facParams = {}.obs;
  final userData = VerificationController.instance.getUserData;
  final paidFactures = {}.obs;
  final unpaidFactures = {}.obs;

  final selectedFactureType = 'Factures non Payées'.obs;

  double get totalPrice => calculateTotalPrice(
        meMontantDb: lastFacture['data']['meMontantDb'],
        redevanceUsd: lastFacture['data']['redevanceUsd'],
        tvaUsd: lastFacture['data']['tvaUsd'],
      );

  @override
  void onInit() {
    super.onInit();

    loadUserInfo();
    // loadFacParam();
    loadFactureRappel();
    loadLastFacture();
    loadFacturePayee();
  }

  Future<void> loadUserInfo() async {
    final userInfo = await authRepo.getUserInfo();

    userName.value =
        userInfo["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"];

    email.value = userInfo[
        "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"];
  }

  // Future<Map<String, dynamic>> loadFacParam() async {
  //   final facParamData = await FactureRepository.instance.getActivePeriode();
  //   final facParamInstance = facParamData['data'][0];
  //     facParams.value = facParamInstance;
  //   return facParams;
  // }

  Future<void> loadLastFacture() async {
    try {
      //Check netowork
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      final facParamData = await FactureRepository.instance.getActivePeriode();
      final periodeData = facParamData['data'][0]['periode'];
      periode.value = periodeData;

      final lastFactureData = await FactureRepository.instance.getLastFacture(
        clientId: userData.id,
        periode: periode.value,
      );

      lastFacture.value = lastFactureData;
    } catch (e) {
      Get.snackbar(
        "Error Loading last Facture",
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

  Future<void> loadFactureRappel() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        return;
      }
      final facturedata = await FactureRepository.instance
          .getFactureRappel(raccordementId: userData.id.toString());

      factureRappel.value = facturedata;
    } catch (e) {
      Get.snackbar(
        "Erreur de chargement",
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

  Future<void> loadFacturePayee() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        return;
      }

      //Load paid Facture
      final facturesData = await FactureRepository.instance
          .getFacturePayee(raccordementId: userData.id.toString());

      paidFactures.value = facturesData;
    } catch (e) {
      Get.snackbar(
        " Loading Facture",
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

  double calculateTotalPrice({
    required double meMontantDb,
    required double redevanceUsd,
    required double tvaUsd,
  }) {
    return meMontantDb + redevanceUsd + tvaUsd;
  }

  String convertDate(String dateStr) {
    DateTime date = DateTime(
        int.parse(dateStr.substring(0, 4)), int.parse(dateStr.substring(4, 6)));

    String formattedDate = DateFormat('MMMM yyyy', 'fr_FR').format(date);

    return formattedDate;
  }
}
