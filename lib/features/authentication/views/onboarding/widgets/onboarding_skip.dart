import 'package:flutter/material.dart';
import 'package:hrm_aqtech/features/authentication/controllers/onboarding_controller.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/devices/device_utils.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: MyDeviceUtils.getBottomNavigationBarHeight(),
        left: MySizes.defaultSpace,
        child: TextButton(
            onPressed: OnboardingController.instance.skipPage,
            child: const Text("Skip")));
  }
}
