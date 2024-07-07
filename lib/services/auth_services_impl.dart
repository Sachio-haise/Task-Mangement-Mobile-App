import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/token.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class AuthServicesImpl extends GetxService {
  final String baseUrl = "http://localhost:8080";

  Future<Token?> registerUser({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required Map<String, dynamic> validationErrors,
  }) async {
    final url = Uri.parse('$baseUrl/api/v1/auth/register');

    final response = await http.post(url,
        headers: {
          'Content-type': 'application/json',
        },
        body: jsonEncode({
          'username': email,
          'firstName': firstName,
          'lastName': lastName,
          'password': password,
          'role': 'USER'
        }));

    if (response.statusCode == 201) {
      // print(response.body);
      return Token.fromJson(jsonDecode(response.body));
    } else {
      // Handle errors
      print('Failed to register user: ${response.body}');
      errorHandler(response, validationErrors);
      return null;
    }
  }

  Future<Token?> loginUser({
    required String email,
    required String password,
    required Map<String, dynamic> validationErrors,
  }) async {
    final url = Uri.parse('$baseUrl/api/v1/auth/login');
    final response = await http.post(url,
        headers: {
          'Content-type': 'application/json',
        },
        body: jsonEncode(
          {'username': email, 'password': password},
        ));
    if (response.statusCode == 200) {
      // print(response.body);
      return Token.fromJson(jsonDecode(response.body));
    } else {
      // Handle errors
      print('Failed to register user: ${response.body}');
      errorHandler(response, validationErrors);
      return null;
    }
  }

  Future<User?> getUser(String token) async {
    final url = Uri.parse('$baseUrl/api/v1/user');
    final response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      print("Get user: ${jsonDecode(response.body)}");
      return User.fromJson(jsonDecode(response.body)['user']);
    }
    print("Fail to get user: ${response.body}");
    return null;
  }

  void errorHandler(dynamic response, Map<String, dynamic> validationErrors) {
    validationErrors.forEach((key, value) => validationErrors[key] = '');
    final errorsResponse = jsonDecode(response.body);
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
