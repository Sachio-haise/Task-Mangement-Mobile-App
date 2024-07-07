import 'package:flutter/material.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String? filePath;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.role,
      required this.filePath});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        role: json['role'],
        filePath: json['filePath']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'role': role,
      'filePath': filePath
    };
  }
}
