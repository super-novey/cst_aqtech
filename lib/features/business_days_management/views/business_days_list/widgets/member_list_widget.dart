
import 'package:flutter/material.dart';
import 'package:hrm_aqtech/common/widgets/container/rounded_container.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';

class MemberListWidget extends StatelessWidget {
  const MemberListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 30,
      child: ListView.builder(
          itemCount: 2,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return MyRoundedContainer(
              margin: const EdgeInsets.only(right: MySizes.sm),
              padding: const EdgeInsets.symmetric(
                  horizontal: MySizes.sm),
              backgroundColor: MyColors.primaryColor,
              child: Center(
                  child: Text(
                "Nguyen Anh Duy",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .apply(color: Colors.white),
              )),
            );
          }),
    );
  }
}
