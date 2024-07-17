import 'dart:convert';

import 'package:flutter_application_1/controller/task_controller.dart';
import 'package:flutter_application_1/models/token.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/services/auth_services_impl.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var user = Rxn<User>();
  final AuthServicesImpl authServicesImpl = Get.put(AuthServicesImpl());
  final TaskController taskController = Get.put(TaskController());
  var isLoading = false.obs;
  var loginStatus = false.obs;
  Map<String, dynamic> validationErrors = {
    'username': '',
    'password': '',
    'firstName': '',
    'lastName': '',
  }.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    String? token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      fetchUser(token);
      taskController.loadTask();
      loginStatus.value = true;
    } else {
      loginStatus.value = false;
    }
  }

  void fetchUser(String token) async {
    isLoading.value = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("token", token);
    final userData = await authServicesImpl.getUser(token);
    if (userData != null) {
      user.value = userData;
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
