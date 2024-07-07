import 'package:get/get.dart';

class UserErrors {
  Map<String, dynamic> validationErrors = {
    'email': null,
    'password': null,
    'firstName': null,
    'lastName': null,
  }.obs;
}
