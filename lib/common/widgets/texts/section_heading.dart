import 'package:flutter/material.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class SectionHeading extends StatelessWidget {
  final String text;
  final Color textColor = MyColors.dartPrimaryColor;

  const SectionHeading({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headlineMedium!
          .apply(color: textColor, fontWeightDelta: 2),
    );
  }
}
