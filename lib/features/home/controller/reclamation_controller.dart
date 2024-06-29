import 'package:device_info_plus/device_info_plus.dart';
import 'package:electrokimo/data/repositories/authentication/facture_repository.dart';
import 'package:electrokimo/features/auth/controllers/verification/verification_controller.dart';
import 'package:electrokimo/utils/formatters/formatters.dart';
import 'package:electrokimo/utils/network/network_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class ReclamationController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxString fileName = ''.obs;
  final userData = VerificationController.instance.getUserData;
  final reclamations = {}.obs;

  final dateController = TextEditingController();
  final numDocumentController = TextEditingController();
  final motifController = TextEditingController();
  final fileController = TextEditingController();

  GlobalKey<FormState> reclamatonFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    getReclammations();
  }

  Future<void> sendReclamation() async {
    try {
      if (!reclamatonFormKey.currentState!.validate()) {
        return;
      }

      // final request = {
      //   "dateSaisieRecl": Formatter.formatDate(selectedDate.value),
      //   "docReference": numDocumentController.text,
      //   "motif": motifController.text,
      //   "file": fileController.text,
      //   "raccordementId": userData.id
      // };

      FactureRepository.instance.addReclamation(
        dateSaisieRecl: Formatter.formatDate(selectedDate.value),
        docReference: numDocumentController.text,
        motif: motifController.text,
        file: fileController.text,
        raccordementId: userData.id,
      );
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

  Future<void> getReclammations() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      final reclemationData = await FactureRepository.instance
          .getListReclamation(clientId: userData.id);

      reclamations.value = reclemationData;
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

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 100000),
      ),
    );

    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      dateController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  Future<bool> requestStoragePermission() async {
    final DeviceInfoPlugin info = DeviceInfoPlugin();
    final AndroidDeviceInfo androidInfo = await info.androidInfo;

    final int androidVersion =
        int.parse(androidInfo.version.release.toString());
    bool havePermission = false;

    if (androidVersion >= 13) {
      final request = await [
        Permission.videos,
        Permission.photos,
        Permission.storage
      ].request();

      havePermission =
          request.values.every((status) => status == PermissionStatus.granted);
    } else {
      final status = await Permission.storage.request();
      havePermission = status.isGranted;
    }

    if (!havePermission) {
      await openAppSettings();
    }
    //print(havePermission);
    return havePermission;
  }

  Future<void> pickFile() async {
    final permission = await requestStoragePermission();

    if (permission) {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles();
        if (result != null) {
          PlatformFile file = result.files.first;
          fileName.value = file.name;
          fileController.text = file.path!;
        }
      } catch (e) {
        throw Exception("Error Picking file: $e");
      }
    } else {
      throw Exception("Storage Permission denied");
    }

    //
  }
}
