import 'package:flutter/material.dart';
import 'package:hrm_aqtech/features/authentication/controllers/onboarding_controller.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/devices/device_utils.dart';

class OnBoardingNext extends StatelessWidget {
  const OnBoardingNext({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MyDeviceUtils.getBottomNavigationBarHeight(),
      right: MySizes.defaultSpace,
      child: ElevatedButton(
          onPressed: OnboardingController.instance.nextPage,
          child: const Icon(Icons.arrow_forward)),
    );
  }
}
