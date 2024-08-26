import 'package:flutter/material.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class MyTextButtonTheme {
  static final lightTextButton = TextButtonThemeData(
      style: TextButton.styleFrom(
          foregroundColor: MyColors.dartPrimaryColor,
          textStyle: const TextStyle(
              color: MyColors.dartPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14)));
}
