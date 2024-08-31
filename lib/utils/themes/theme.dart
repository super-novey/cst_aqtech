import 'package:flutter/material.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/themes/custom_themes/app_bar_theme.dart';
import 'package:hrm_aqtech/utils/themes/custom_themes/elevated_button_theme.dart';
import 'package:hrm_aqtech/utils/themes/custom_themes/outline_button_theme.dart';
import 'package:hrm_aqtech/utils/themes/custom_themes/text_button_theme.dart';
import 'package:hrm_aqtech/utils/themes/custom_themes/text_field_theme.dart';
import 'package:hrm_aqtech/utils/themes/custom_themes/text_theme.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
      //primaryColor: MyColors.primaryColor,
      colorScheme: const ColorScheme.light(
        primary: MyColors.dartPrimaryColor,
        onPrimary: Colors.black, // Header text color
        surface: Colors.white, // Calendar background color
        onSurface: MyColors.primaryTextColor,
        
      ),
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      appBarTheme: MyAppBarTheme.lightAppBarTheme,
      textTheme: MyTextTheme.lightTextTheme,
      elevatedButtonTheme: MyElevatedButtonTheme.lightElevatedButtonTheme,
      textButtonTheme: MyTextButtonTheme.lightTextButton,
      inputDecorationTheme: MyTextFieldTheme.lightInputDecorationTheme,
      textSelectionTheme: MyTextFieldTheme.lightTextSelectionTheme,
      outlinedButtonTheme: MyOutlineButtonTheme.lightOutlineButtonTheme);
}
