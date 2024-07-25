import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.errorMessage,
      this.isForPwd = false,
      this.minLines = 1,
      this.textColor});

  final TextEditingController controller;
  final String? errorMessage;
  final bool isForPwd;
  final int minLines;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextFormField(
          minLines: isForPwd ? null : minLines,
          maxLines: isForPwd ? 1 : null,
          controller: controller,
          obscureText: isForPwd,
          cursorColor: AppColors.primaryColor,
          style: TextStyle(color: textColor ?? Colors.black),
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
