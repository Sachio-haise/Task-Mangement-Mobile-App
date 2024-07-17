import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';

class ErrorHandlingService extends GetxService {
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
