import 'package:flutter/material.dart';

extension IntExtensions on int? {
  int validate({int value = 0}) => this ?? value;

  Widget get h => SizedBox(
        height: this?.toDouble(),
      );

  Widget get w => SizedBox(
        width: this?.toDouble(),
      );
}
