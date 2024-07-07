import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/strings.dart';

class RepTextField extends StatelessWidget {
  const RepTextField({
    super.key,
    required this.controller,
    this.isForDescription = false,
  });

  final TextEditingController controller;
  final bool isForDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        title: TextFormField(
          controller: controller,
          maxLines: isForDescription ? null : 6,
          cursorHeight: isForDescription ? null : 40,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            border: isForDescription ? null : InputBorder.none,
            counter: Container(),
            hintText: isForDescription ? AppString.addNote : null,
            prefixIcon: isForDescription
                ? const Icon(
                    Icons.bookmark_border,
                    color: Colors.grey,
                  )
                : null,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300)),
          ),
          onFieldSubmitted: (value) => {},
          onChanged: (value) => {},
        ),
      ),
    );
  }
}
