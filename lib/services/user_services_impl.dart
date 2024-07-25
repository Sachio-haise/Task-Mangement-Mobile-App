import 'dart:convert';
import 'dart:io';

import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/services/error_handling_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServicesImpl extends GetxService {
  final AuthController _authController = Get.put(AuthController());
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

  Future<User?> updateProfile(
      {required String firstName,
      required String lastName,
      required String description,
      required File? file}) async {
    final url = Uri.parse("$baseUrl/api/v1/user/update");
    // extract token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");

    // make request for file
    var request = http.MultipartRequest("POST", url);

    // set header
    request.headers['Authorization'] = "Bearer $token";
    request.headers['Content-Type'] = "multipart/form-data";

    if (file != null) {
      // read file
      var stream = http.ByteStream(Stream.castFrom(file.openRead()));

      // get file bites
      var length = await file.length();

      // make http file
      final multipartFile = http.MultipartFile('file', stream, length,
          filename: basename(file.path));
      request.files.add(multipartFile);
    }

    request.fields.addAll({
      'firstName': firstName,
      'lastName': lastName,
      'description': description
    });
    final response = await request.send();
    final responseData = await http.Response.fromStream(response);
    if (responseData.statusCode == 200) {
      _authController.fetchUser(token!);
      return User.fromJson(jsonDecode(responseData.body));
    } else {
      return null;
    }
  }

  Future<User?> changePassword({
    required String oldPassword,
    required String password,
    required Map<String, dynamic> validationErrors,
  }) async {
    // extract token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");

    final Uri url = Uri.parse("$baseUrl/api/v1/user/change-password");
    final responseData = await http.post(url,
        headers: {
          'Content-type': 'application/json',
          'Authorization': "Bearer $token"
        },
        body: jsonEncode({'password': password, 'oldPassword': oldPassword}));

    print(responseData.body);
    if (responseData.statusCode == 200) {
      return User.fromJson(jsonDecode(responseData.body));
    }
    print(responseData.body);
    errorHandlingService.errorHandler(responseData, validationErrors);
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
