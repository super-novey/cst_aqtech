import 'package:flutter/material.dart';
import 'package:hrm_aqtech/common/widgets/header/circular_container.dart';
import 'package:hrm_aqtech/common/widgets/header/curved_edges_widget.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class MyPrimaryHeaderContainer extends StatelessWidget {
  final Widget child;
  const MyPrimaryHeaderContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MyCurvedEdgesWidget(
      child: Container(
        color: MyColors.primaryColor,
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: MyCicularContainer(
                backgroudColor: MyColors.lightPrimaryColor.withOpacity(0.2),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: MyCicularContainer(
                backgroudColor: MyColors.lightPrimaryColor.withOpacity(0.2),
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}
