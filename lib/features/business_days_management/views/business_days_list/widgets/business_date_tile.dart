import 'package:flutter/material.dart';
import 'package:hrm_aqtech/common/widgets/container/rounded_container.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class BusinessDateTile extends StatelessWidget {
  const BusinessDateTile({super.key});

  @override
  Widget build(BuildContext context) {
    return MyRoundedContainer(
      width: 100,
      height: 100,
      backgroundColor: MyColors.dartPrimaryColor,
    );
  }
}
