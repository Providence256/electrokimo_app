import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class FilePickerController extends GetxController {
  final RxString fileName = ''.obs;
  final fileController = TextEditingController();

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
          fileController.text = file.name;
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
