import 'package:flutter_application_1/services/user_services_impl.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserServicesImpl userServicesImpl = Get.put(UserServicesImpl());
  final Map<String, dynamic> validationErrors =
      {'username': '', 'code': '', 'password': ''}.obs;
  var isLoading = false.obs;

  Future<String?> forgetPassword({required String email}) async {
    isLoading.value = true;
    validationErrors.forEach((key, value) => validationErrors[key] = '');

    final responseData = await userServicesImpl.sendMailToUser(
        email: email, validationErrors: validationErrors);

    isLoading.value = false;

    return responseData;
  }

  Future<String?> checkCode(
      {required String code, required String username}) async {
    isLoading.value = true;
    final responseData = await userServicesImpl.checkCode(
        code: code, username: username, validationErrors: validationErrors);
    isLoading.value = false;
    return responseData;
  }

  Future<String?> resetPassword({
    required String email,
    required String code,
    required String password,
  }) async {
    isLoading.value = true;
    final responseData = await userServicesImpl.resetPassword(
        username: email, code: code, password: password);
    isLoading.value = false;
    return responseData;
  }
}
