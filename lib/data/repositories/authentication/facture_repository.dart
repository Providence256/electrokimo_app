import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:path/path.dart';

class FactureRepository extends GetxController {
  static FactureRepository get instance => Get.find();

  static const String _baseUrl = "https://www.bsielectrokimo.com/api";

  //variables
  final deviceStorage = GetStorage();

  Future<void> addReclamation({
    required String dateSaisieRecl,
    required String docReference,
    required String motif,
    required String file,
    required int raccordementId,
  }) async {
    final token = deviceStorage.read("token");
    final url = Uri.parse('$_baseUrl/v1/noterecl/addreclamationmobile');
    final request = http.MultipartRequest('POST', url);

    //Add Fields
    request.fields['dateSaisieRecl'] = dateSaisieRecl;
    request.fields['docReference'] = docReference;
    request.fields['motif'] = motif;
    request.fields['raccordementId'] = raccordementId.toString();
    request.fields['id'] = "0";

    //Add File
    final filePath = await http.MultipartFile.fromPath('file', file,
        filename: basename(file));
    request.files.add(filePath);

    //Add Headers
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    //Send Request
    final response = await request.send();

    final responseBody = await http.Response.fromStream(response);

    if (responseBody.statusCode == 200) {
      print("Reclamation added");
    } else {
      print("Failed to add reclamation: ${responseBody.body}");
    }
  }

  Future<Map<String, dynamic>> getActivePeriode() async {
    final token = await deviceStorage.read("token");
    final response = await http.get(
      Uri.parse("$_baseUrl/v1/facparam/all-unclose"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> periodeData = json.decode(response.body);
      if (periodeData['succeeded'] == true) {
        return periodeData;
      } else {
        periodeData = {};
        return periodeData;
      }
    } else {
      final errors = json.decode(response.body);

      throw Exception('Failed to load data: ${Get.snackbar(
        "Erreur",
        errors.toString(),
        isDismissible: true,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        colorText: Colors.white,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(20),
        icon: const Icon(
          Iconsax.warning_2,
          color: Colors.white,
        ),
      )}');
    }
  }

  //get List Reclamation
  Future<Map<String, dynamic>> getListReclamation(
      {required int clientId}) async {
    final token = await deviceStorage.read("token");
    final response = await http.get(
        Uri.parse("$_baseUrl/v1/noterecl/getallreclamationbyclient/$clientId"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200) {
      Map<String, dynamic> reclemationData = json.decode(response.body);
      if (reclemationData['succeeded'] == true) {
        return reclemationData;
      } else {
        reclemationData = {};
        return reclemationData;
      }
    } else {
      final errors = json.decode(response.body);

      throw Exception('Failed to load data: ${Get.snackbar(
        "Erreur",
        errors.toString(),
        isDismissible: true,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        colorText: Colors.white,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(20),
        icon: const Icon(
          Iconsax.warning_2,
          color: Colors.white,
        ),
      )}');
    }
  }

  //Find last Facture
  Future<Map<String, dynamic>> getLastFacture({
    required int clientId,
    required String periode,
  }) async {
    final token = await deviceStorage.read("token");
    final response = await http.get(
        Uri.parse("$_baseUrl/v1/dashboard/getlastfacture/$clientId/$periode"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {
      Map<String, dynamic> lastFacData = json.decode(response.body);
      if (lastFacData['succeeded'] == true) {
        return lastFacData;
      } else {
        lastFacData = {};
        return lastFacData;
      }
    } else {
      final errors = json.decode(response.body);

      throw Exception('Failed to load data: ${Get.snackbar(
        "Erreur",
        errors.toString(),
        isDismissible: true,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        colorText: Colors.white,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(20),
        icon: const Icon(
          Iconsax.warning_2,
          color: Colors.white,
        ),
      )}');
    }
  }

  //Facture Payee
  Future<Map<String, dynamic>> getFacturePayee(
      {required String raccordementId}) async {
    final token = await deviceStorage.read("token");
    final response =
        await http.post(Uri.parse('$_baseUrl/v1/extrait/facturepayees'),
            body: jsonEncode({
              "raccordementId": raccordementId,
              "agenceId": 0,
            }),
            headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200) {
      Map<String, dynamic> factureData = json.decode(response.body);
      if (factureData['succeeded'] == true) {
        return factureData;
      } else {
        factureData = {};

        return factureData;
      }
    } else {
      final errors = json.decode(response.body);

      throw Exception('Failed to load data: ${Get.snackbar(
        "Erreur",
        errors.toString(),
        isDismissible: true,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        colorText: Colors.white,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(20),
        icon: const Icon(
          Iconsax.warning_2,
          color: Colors.white,
        ),
      )}');
    }
  }

  //Rappel de Facture
  Future<Map<String, dynamic>> getFactureRappel(
      {required String raccordementId}) async {
    final token = await deviceStorage.read("token");
    final response = await http.post(
      Uri.parse('$_baseUrl/v1/extrait/rappelfactures'),
      body: jsonEncode({
        "raccordementId": raccordementId,
        "agenceId": 0,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> factureData = json.decode(response.body);
      if (factureData['succeeded'] == true) {
        return factureData;
      } else {
        factureData = {};
        return factureData;
      }
    } else {
      final errors = json.decode(response.body);

      throw Exception('Failed to load data: ${Get.snackbar(
        "Erreur",
        errors.toString(),
        isDismissible: true,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        colorText: Colors.white,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(20),
        icon: const Icon(
          Iconsax.warning_2,
          color: Colors.white,
        ),
      )}');
    }
  }
}
