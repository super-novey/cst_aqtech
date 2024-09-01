import 'package:flutter/material.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class DashedLine extends StatelessWidget {
  final Color dashColor;
  const DashedLine({
    super.key,
    this.dashColor = MyColors.secondaryTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        double dashWidth = 3;
        int dashCount = (constraints.maxWidth / (2 * dashWidth)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(color: dashColor),
              ),
            );
          }),
        );
      }),
    );
  }
}
