import 'package:flutter/material.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/devices/device_utils.dart';

class OnBoardingPage extends StatelessWidget {
  final String image, title, subTitle;
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          width: MyDeviceUtils.getScreenWidth(context) * 0.8,
          height: MyDeviceUtils.getScreenHeight(context) * 0.6,
          image: AssetImage(image),
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: MyColors.dartPrimaryColor),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: MySizes.spaceBtwItems,
        ),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
