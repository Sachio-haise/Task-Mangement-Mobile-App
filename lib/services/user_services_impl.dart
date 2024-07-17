import 'dart:convert';

import 'package:flutter_application_1/services/error_handling_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserServicesImpl extends GetxService {
  final String baseUrl = "http://localhost:8080";
  final ErrorHandlingService errorHandlingService =
      Get.put(ErrorHandlingService());

  Future<String?> sendMailToUser({
    required String email,
    required Map<String, dynamic> validationErrors,
  }) async {
    final url = Uri.parse("$baseUrl/api/v1/auth/forget-password");
    final responseData = await http.post(url,
        headers: {
          'Content-type': 'application/json',
        },
        body: jsonEncode({'username': email}));
    if (responseData.statusCode == 200) {
      return "mailed";
    }
    print(responseData.body);
    errorHandler(responseData, validationErrors);
    return null;
  }

  Future<String?> checkCode({
    required String code,
    required String username,
    required Map<String, dynamic> validationErrors,
  }) async {
    final url = Uri.parse("$baseUrl/api/v1/auth/check-code");
    final responseData = await http.post(url,
        headers: {
          'Content-type': 'application/json',
        },
        body: jsonEncode({'code': code, 'username': username}));
    if (responseData.statusCode == 200) {
      return "checked";
    }
    print(responseData.body);
    errorHandlingService.errorHandler(responseData, validationErrors);
    return null;
  }

  Future<String?> resetPassword({
    required String username,
    required String code,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/api/v1/auth/update-password");
    final responseData = await http.post(url,
        headers: {
          'Content-type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'code': code,
          'password': password,
        }));

    print(responseData.body);
    if (responseData.statusCode == 200) {
      return 'updated';
    }
    return null;
  }

  void errorHandler(dynamic response, Map<String, dynamic> validationErrors) {
    validationErrors.forEach((key, value) => validationErrors[key] = '');
    final errorsResponse = jsonDecode(response.body);
    print(errorsResponse);
    if (errorsResponse.containsKey('errors')) {
      final errors = errorsResponse['errors'];
      errors.forEach((key, value) {
        if (validationErrors.containsKey(key)) {
          validationErrors[key] = value;
        }
      });
    }
  }
}
