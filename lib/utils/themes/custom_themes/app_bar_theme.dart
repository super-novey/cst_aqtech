import 'package:flutter/material.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';

class MyAppBarTheme {
  static const lightAppBarTheme = AppBarTheme(
      scrolledUnderElevation: 0,
      elevation: 0,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.white, size: MySizes.iconLg),
      actionsIconTheme:
          IconThemeData(color: Colors.white, size: MySizes.iconLg),
      titleTextStyle: TextStyle(
          fontSize: MySizes.fontSizeLg,
          fontWeight: FontWeight.w600,
          color: MyColors.iconColor));
}
