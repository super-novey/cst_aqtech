import 'package:flutter/material.dart';
import 'package:hrm_aqtech/features/authentication/controllers/onboarding_controller.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/devices/device_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    return Positioned(
      bottom: MyDeviceUtils.getBottomNavigationBarHeight() * 3,
      left: 0,
      right: 0,
      child: Align(
        alignment: Alignment.center,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          count: 3,
          effect: const WormEffect(
              activeDotColor: MyColors.dartPrimaryColor,
              dotColor: MyColors.accentColor,
              dotHeight: 10,
              dotWidth: 10,
              radius: 10),
        ),
      ),
    );
  }
}
