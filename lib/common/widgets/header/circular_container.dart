import 'package:flutter/material.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class MyCicularContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final EdgeInsets? margin;
  final Widget? child;
  final Color backgroudColor;

  const MyCicularContainer({
    super.key,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.padding = 0,
    this.margin,
    this.backgroudColor = MyColors.lightPrimaryColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(0),
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(400), color: backgroudColor),
      child: child,
    );
  }
}
