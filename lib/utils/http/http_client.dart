import 'dart:convert';

import 'package:electrokimo/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

class HttpClient {
  static const String _baseUrl = "https://www.bsielectrokimo.com/api";

  //Method to handle the http response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['succeeded'] == true) {
        return responseBody;
      } else {
        LoaderScreen.stopLoading();
        throw Exception('Failed to load data: ${Get.snackbar(
          "Pas Disponible",
          responseBody['message'],
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
    } else {
      // throw Exception('Failed to load data: ${json.decode(response.body)}');

      final errors = json.decode(response.body);
      // print(errors.toString());
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

  //Method to make a GET Request
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'), headers: {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    });

    return _handleResponse(response);
  }

  //Method to make a POST request
  static Future<Map<String, dynamic>> post(
      String endpoint, dynamic data) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }
}
