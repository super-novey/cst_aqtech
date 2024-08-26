import 'package:flutter/material.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';

class MyTextFieldTheme {
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    prefixIconColor: MyColors.accentColor,
    suffixIconColor: MyColors.accentColor,
    hintStyle: const TextStyle()
        .copyWith(fontSize: MySizes.fontSizeSm, color: MyColors.accentColor),
    border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusLg),
        borderSide: const BorderSide(width: 1, color: Colors.grey)),
    enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusLg),
        borderSide: const BorderSide(width: 1, color: Colors.grey)),
    focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusLg),
        borderSide:
            const BorderSide(width: 1, color: MyColors.dartPrimaryColor)),
    disabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(MySizes.borderRadiusLg),
        borderSide: const BorderSide(width: 1, color: Colors.grey)),
  );

  static TextSelectionThemeData lightTextSelectionTheme =
      const TextSelectionThemeData(
          cursorColor: MyColors.dartPrimaryColor,
          selectionColor: MyColors.lightPrimaryColor,
          selectionHandleColor: MyColors.accentColor);
}
