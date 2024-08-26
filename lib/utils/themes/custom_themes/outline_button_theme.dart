import 'package:flutter/material.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class MyOutlineButtonTheme {
  MyOutlineButtonTheme._();

  static final OutlinedButtonThemeData lightOutlineButtonTheme =
      OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              elevation: 0,
              foregroundColor: Colors.black,
              side: const BorderSide(color: MyColors.dartPrimaryColor),
              textStyle: const TextStyle(
                  fontSize: 16,
                  color: MyColors.primaryTextColor,
                  fontWeight: FontWeight.w600),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14))));
}
