import 'dart:convert';

import 'package:electrokimo/utils/http/http_client.dart';
import 'package:electrokimo/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  static const String _baseUrl = "https://www.bsielectrokimo.com/api";

  //variables
  final deviceStorage = GetStorage();

  //Check Police Abonnement
  Future<Map<String, dynamic>> checkpa({required String pa}) async {
    final response = HttpClient.get("identity/token/checkpa/$pa");

    return response;
  }

  Future<Map<String, dynamic>> loginClient(
      {required String userName, required String password}) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/identity/token/mobile'),
        body: jsonEncode({
          'userName': userName,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      Map<String, dynamic> userData = json.decode(response.body);
      if (userData['succeeded'] == true) {
        return userData;
      } else {
        LoaderScreen.stopLoading();
        throw Exception('Failed to load data: ${Get.snackbar(
          "Avertissement",
          userData['message'],
          isDismissible: true,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          colorText: Colors.white,
          backgroundColor: Colors.orange,
          margin: const EdgeInsets.all(20),
          icon: const Icon(
            Iconsax.warning_2,
            color: Colors.white,
          ),
        )}');
      }
    } catch (e) {
      throw 'Something went wrong ${Get.snackbar(
        "Pas Disponible",
        e.toString(),
        isDismissible: true,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        colorText: Colors.white,
        backgroundColor: Colors.orange,
        margin: const EdgeInsets.all(20),
        icon: const Icon(
          Iconsax.warning_2,
          color: Colors.white,
        ),
      )}';
    }
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    final token = await deviceStorage.read("token");
    if (token != null) {
      final user = Jwt.parseJwt(token);

      return user;
    }

    throw Exception("no token found");
  }

  Future<Map<String, dynamic>> registerClient({
    required String pa,
    String? email,
    required String phoneNumber,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/identity/account/newclientaccount'),
      body: jsonEncode({
        'pa': pa,
        'phoneNumber': phoneNumber,
        'email': email,
        'password': password,
        'confirmPassword': true
      }),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> userData = json.decode(response.body);
      if (userData['succeeded'] == true) {
        return userData;
      } else {
        userData = {};
        return userData;
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
