import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/colors.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.errorMessage,
    this.isForPwd = false,
  });

  final TextEditingController controller;
  final String? errorMessage;
  final isForPwd;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextFormField(
          controller: controller,
          obscureText: isForPwd,
          cursorColor: AppColors.primaryColor,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 5),
            isDense: true,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor)),
          ),
          onChanged: (value) => {},
          onFieldSubmitted: (value) => {},
        ),
        errorMessage == null
            ? const SizedBox.shrink()
            : Text(
                errorMessage!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
      ]),
    );
  }
}
