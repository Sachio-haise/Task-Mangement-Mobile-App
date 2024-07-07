import 'dart:convert';
import 'dart:ffi';

import 'package:flutter_application_1/models/token.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/services/auth_services_impl.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var user = Rx<User?>(null);
  final AuthServicesImpl authServicesImpl = Get.put(AuthServicesImpl());
  var isLoading = false.obs;
  Map<String, dynamic> validationErrors = {
    'username': '',
    'password': '',
    'firstName': '',
    'lastName': '',
  }.obs;

  void fetchUser(String token) async {
    isLoading.value = true;
    final getUser = await authServicesImpl.getUser(token);
    if (getUser != null) {
      user.value = getUser;
    }
    isLoading.value = false;
  }

  Future<Token?> register({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    isLoading.value = true;

    final responseData = await authServicesImpl.registerUser(
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password,
        validationErrors: validationErrors);

    if (responseData != null) {
      fetchUser(responseData.token);
      validationErrors.forEach((key, value) => validationErrors[key] = '');
    }

    isLoading.value = false;
    return responseData;
  }

  Future<Token?> login({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    final responseData = await authServicesImpl.loginUser(
        email: email, password: password, validationErrors: validationErrors);

    if (responseData != null) {
      fetchUser(responseData.token);
      validationErrors.forEach((key, value) => validationErrors[key] = '');
    }

    isLoading.value = false;
    return responseData;
  }
}
